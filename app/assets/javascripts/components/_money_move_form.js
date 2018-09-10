import app from '../app';

const createCloseButton = function() {
  const closeButton = document.createElement('div');
  closeButton.innerHTML = `<a class=\"button\" href=\"#\"><img src=\"${pondoAssets['arrow_downward.svg']}\"></a>`;
  closeButton.classList.add('close-button');
  return closeButton;
};

app.moneyMoveForm = id =>
  app.hashChange(id,
    function() {
      pu.selectAndEach(`a[href=\"#${id}\"]`, function(link) {
        link.href = "#";
        link.classList.add('active');
        return link.dataset.previous = `#${id}`;
      });

      return pu.selectAndEach(`#${id}`, function(el) {
        el.appendChild(createCloseButton());
        return el.classList.add('active');
      });
    },

    function() {
      pu.selectAndEach(`#${id}`, function(el) {
        el.removeChild(el.getElementsByClassName('close-button')[0]);
        return el.classList.remove('active');
      });

      return pu.selectAndEach(`a[data-previous=\"#${id}\"]`, function(link) {
        link.href=`#${id}`;
        link.classList.remove('active');
        return link.dataset.previous = '';
      });
  })
;

