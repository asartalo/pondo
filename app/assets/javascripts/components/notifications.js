import app from '../app';

app.load('.notifications', function(notifications) {
  const el = notifications[0];
  let shown = true;
  const hide = function() {
    if (shown) {
      return pu.animateCss(el, 'fade-out-down', function() {
        pu.hide(el);
        unloader();
        return shown = false;
      });
    }
  };

  var unloader = pu.listenOnce(el, 'click', hide);
  return app.delay(5, hide);
});


