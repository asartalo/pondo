import $ from 'jquery';
import app from '../app';

const $document = $(document);

app.hashChange("header-menu",
  function() {
    pu.selectAndEach('#header-menu', el => el.classList.add('active'));

    return pu.selectAndEach('a[href="#"]', function(el) {
      const button = el;
      return app.showOverlay(function() {
        if (button) { return button.click(); }
      });
    });
  },

  function() {
    pu.selectAndEach('#header-menu', el => el.classList.remove('active'));

    return app.hideOverlay();
});


