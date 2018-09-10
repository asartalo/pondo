
import app from '../app';

let unloader = null;

let opening = false;
app.showOverlay = function(callback) {
  opening = true;
  pu.selectAndEach('body', body => body.classList.add('disable-interaction'));

  pu.selectAndEach('.disable-overlay', overlay =>
    unloader = pu.listenOnce(overlay, 'click', function(e) {
      if (callback) {
        return callback.call(overlay, e);
      }
    })
  );
  return app.delay(0.03, () => opening = false);
};

app.hideOverlay = function(callback) {
  app.delay(0.03, function() {
    if (!opening) {
      pu.selectAndEach('.disable-overlay', overlay =>
        pu.animateCss(overlay, 'fade-out', () =>
          pu.selectAndEach('body', body => body.classList.remove('disable-interaction'))
        )
      );
    }

    return unloader();
  });

  if (callback) {
    return callback();
  }
};

