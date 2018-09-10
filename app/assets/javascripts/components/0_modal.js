import app from '../app';

const closeButton = document.createElement('div');
closeButton.innerHTML = `<a class=\"button\" href=\"#\"><img src=\"${pondoAssets['close.svg']}\"></a>`;
closeButton.classList.add('close-button');

app.modal = (id, onLoad = null, onUnload = null) =>
  app.hashChange(id,
    function() {
      pu.selectAndEach(`#${id}`, function(wrapper) {
        wrapper.classList.add('active');
        pu.selectAndEach(`#${id} .modal-content`, function(el) {
          el.appendChild(closeButton);
          pu.animateCss(el, 'zoom-in');
        });
      });

      pu.selectAndEach(`#${id} a[href=\"#\"]`, function(el) {
        const cancel = el;
         app.showOverlay(function() {
          if (cancel) { cancel.click(); }
        });
      });
    },


    function() {
      pu.selectAndEach(`#${id} .modal-content`, el =>
        pu.animateCss(el, 'zoom-out', function() {
          el.parentElement.classList.remove('active');
          el.removeChild(closeButton);
        })
      );

      app.hideOverlay();
  })
;

