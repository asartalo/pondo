// Pondo Utilities
this.pu = (function(document, window) {
  const whenReady = function(fn) {
    document.addEventListener("DOMContentLoaded", fn);
    return () => document.removeEventListener("DOMContentLoaded", fn);
  };

  const ifElseFn = function(test, fn1, fn2) {
    if (test) { return fn1; } else { return fn2; }
  };

  const merge = (a, b) => Object.assign(a, b);

  const eventFactory = ifElseFn(
    window.CustomEvent,
    (event, data) => new CustomEvent(event, {detail: data, bubbles: true, cancelable: true}),
    function(event, data) {
      const theEvent = document.createEvent('CustomEvent');
      theEvent.initCustomEvent(event, true, true, data);
      return theEvent;
  });

  const animationEndEvents = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
  const animateCss = function(el, animation, fn) {
    const { classList } = el;
    classList.add('animated');
    classList.add(animation);
    return listenOnce(el, animationEndEvents, function() {
      if (fn) { fn(); }
      classList.remove('animated');
      return classList.remove(animation);
    });
  };

  const listenOnce = function(el, eventsStr, fn) {
    const events = eventsStr.split(/\s/);
    const unloader = () =>
      Array.from(events).map((event) =>
        el.removeEventListener(event, handler))
    ;

    var handler = function(e) {
      fn.call(el, e);
      return unloader();
    };

    for (let event of Array.from(events)) {
      el.addEventListener(event, handler);
    }

    return unloader;
  };

  const eventDelegate = (event, selector, handler) =>
    document.addEventListener(event, function(e) {
      let { target } = e;
      while (target && (target !== this)) {
        if (target.matches(selector)) {
          e.current = target;
          handler.call(target, e);
          break;
        }
        target = target.parentNode;
      }
    })
  ;

  const eventListen = (event, handler) =>
    document.addEventListener(event, e => handler.call(document, e))
  ;

  const triggerEvent = function(event, data) {
    if (data == null) { data = {}; }
    return triggerElementEvent(document, event, data);
  };

  var triggerElementEvent = function(el, event, data) {
    if (data == null) { data = {}; }
    el.dispatchEvent(eventFactory(event, data));
    return event;
  };

  const handleLinkClicks = fn =>
    eventDelegate('click', 'a[href]', function(e) {
      const link = e.current;
      const url = new URL(link.href);
      return fn(url, e);
    })
  ;

  const handleFormSubmits = fn =>
    eventDelegate('submit', 'form', function(e) {
      const form = e.current;
      return fn(form, e);
    })
  ;

  const getContentOfElement = function(selector, defaultValue = null) {
    const node = document.querySelector(selector);
    if (node) { return node.content; } else { return defaultValue; }
  };

  const isCurrentPageReloaded = () => window.performance.navigation.type === 1;

  const select = selector => document.querySelectorAll(selector);

  const selectAnd = function(selector, fn) {
    const found = select(selector);
    return fn.call(fn, found);
  };

  const selectAndEach = (selector, fn) =>
    selectAnd(selector, elements =>
      Array.from(elements).map((element) =>
        fn.call(fn, element))
    )
  ;

  const hide = el => el.style.display = 'none';

  // Stolen from Turbolinks
  const uuid = function() {
    let result = "";
    for (let i = 1; i <= 36; i++) {
      if ([9, 14, 19, 24].includes(i)) {
        result += "-";
      } else if (i === 15) {
        result += "4";
      } else if (i === 20) {
        result += (Math.floor(Math.random() * 4) + 8).toString(16);
      } else {
        result += Math.floor(Math.random() * 15).toString(16);
      }
    }
    return result;
  };

  const doc = document;
  const docEl = doc.documentElement;
  const requestFullScreenFn = docEl.requestFullscreen || docEl.mozRequestFullScreen || docEl.webkitRequestFullScreen || docEl.msRequestFullscreen;
  const cancelFullScreenFn = doc.exitFullscreen || doc.mozCancelFullScreen || doc.webkitExitFullscreen || doc.msExitFullscreen;

  const isFullScreen = () => doc.fullscreenElement || doc.mozFullScreenElement || doc.webkitFullscreenElement || doc.msFullscreenElement;

  const requestFullScreen = function() {
    if (!isFullScreen()) {
      return requestFullScreenFn.call(docEl);
    }
  };

  const cancelFullScreen = function() {
    if (isFullScreen()) {
      return cancelFullScreenFn.call(doc);
    }
  };

  return {
    getContentOfElement,
    ifElseFn,
    merge,
    listenOnce,
    createEvent: eventFactory,
    whenReady,
    eventDelegate,
    eventListen,
    triggerEvent,
    triggerElementEvent,
    handleLinkClicks,
    handleFormSubmits,
    isCurrentPageReloaded,
    uuid,
    animateCss,
    select,
    selectAnd,
    selectAndEach,
    hide,
    requestFullScreen,
    cancelFullScreen
  };
})(document, window);


