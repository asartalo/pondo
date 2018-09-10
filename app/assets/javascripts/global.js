import $ from 'jquery';

const $document = $(document);

$document.on('ajax:complete', function(e, response) {
  const result = response.responseJSON;
  if (result && result.for && (result.for.length > 0)) {
    let status = "error";
    if ((response.status < 300) && result.success) {
      status = "success";
    }
    const event = $.Event(`ax:${result.for}:${status}`);
    event.target = e.target;
    return $(document).trigger(event, result);
  }
});

const dispatchUnloadEvent = function() {
  const event = document.createEvent('Events');
  event.initEvent('turbolinks:unload', true, false);
  document.dispatchEvent(event);
};

addEventListener('beforeunload', dispatchUnloadEvent);
addEventListener('turbolinks:before-render', dispatchUnloadEvent);

