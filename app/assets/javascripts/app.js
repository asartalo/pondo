import $ from 'jquery';

const app = {};

const $document = $(document);

// Load and unload depending if elements exist on the page
app.load = function(selector, loader, unloader) {
  const loadListener = function() {
    const elements = pu.select(selector);
    if ((elements.length > 0) && loader) {
      return loader(elements);
    }
  };

  pu.eventListen('nitrolinks:load', loadListener);

  if (unloader) {
    const unloadListener = function() {
      const elements = $(selector);
      if (elements.length > 0) {
        return unloader(elements);
      }
    };
    return pu.eventListen('nitrolinks:visit', unloadListener);
  }
};

const funcKeyExec = function(hash, key, ...args) {
  if (key) {
    const func = hash[key];
    if (func) {
      return func.apply(func, args);
    }
  }
};

const hashChangeLoaders = {};
const hashChangeUnloaders = {};

window.addEventListener("hashchange", function(e) {
  funcKeyExec(hashChangeUnloaders, (new URL(e.oldURL)).hash);
  return funcKeyExec(hashChangeLoaders, (new URL(e.newURL)).hash);
});

app.hashChange = function(hash, loader, unloader) {
  hashChangeLoaders[`#${hash}`] = loader;
  return hashChangeUnloaders[`#${hash}`] = unloader;
};

pu.eventListen('nitrolinks:load', () => funcKeyExec(hashChangeLoaders, window.location.hash));


// app.afterLoad = (selector, loader) ->
//   myLoader = (e) ->
//     if selector
//       elements = $(selector)
//       if elements.length > 0 && loader
//         loader(elements)
//     else
//       loader(e.target)
//     $document.off 'nitrolinks:load', myLoader
//
//   $document.on 'nitrolinks:load',  myLoader

app.reload = () => nitrolinks.visit(window.location.toString());

app.delay = (seconds, callback) => window.setTimeout(callback, seconds * 1000);

let dialogElement = null;
let dialogId = null;

const getDialog = function() {
  const dialog = $('dialog')[0];
  // if !dialog.showModal
  //   dialogPolyfill.registerDialog(dialog)
  return dialog;
};

const showDialog = function(options) {
  if (options == null) { options = {}; }
  const dialog = getDialog();
  dialog.showModal();
  const event = $.Event('dialog-load');
  event.target = dialog;
  return $document.trigger(event);
};

const closeDialog = function() {
  const dialog = getDialog();
  if (!dialog) { return; }
  const form = $(dialog).find('form');
  if (form.length > 0) {
    form[0].reset();
  }
  if (dialog.open) {
    dialog.close();
  }
  if (dialogId) {
    $(dialogId).append(dialogElement);
  } else {
    if (dialogElement) { dialogElement.detach(); }
  }
  dialogElement = null;
  return dialogId = null;
};

app.showDialog = showDialog;
app.closeDialog = closeDialog;

$document.on('click', 'dialog .close', e => closeDialog());

$document.on('nitrolinks:visit', () => closeDialog());

$document.on('click', '.dialog-open', function(e) {
  let button;
  e.preventDefault();
  const target = $(e.target);
  if (target.is('.dialog-open')) {
    button = target;
  } else {
    button = target.closest('.dialog-open');
  }
  dialogId = button.attr('href');
  const container = $(`${dialogId}`);
  const width = container.data('width') || "";
  dialogElement = $(`${dialogId} > *`).detach();

  $('dialog').css({width}).find('.dialog-content').append(dialogElement);
  return showDialog();
});

$document.on('click', '.dialog-open-remote', function(e) {
  let button;
  e.preventDefault();
  const target = $(e.target);
  if (target.is('.dialog-open-remote')) {
    button = target;
  } else {
    button = target.closest('.dialog-open-remote');
  }
  const location = button.attr('href');
  const width = button.data('width') || "";
  return $.ajax(
    location, {
    success(data, status) {
      dialogElement = $(data);
      $('dialog').css({width}).find('.dialog-content').append(dialogElement);
      return showDialog();
    }
  }
  );
});

window.app = app;

export default app;

