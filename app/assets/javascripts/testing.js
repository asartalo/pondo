//= require 'jquery'
//= require nitrolinks/load-helper

class PondoTesting {
  constructor(window) {
    this.window = window;
    this.errors = [];
  }

  listen() {
    return this.window.addEventListener('error', e => {
      return this.addToErrors(e);
    });
  }

  addToErrors(e) {
    if (e.error) {
      this.errors.push(e.error.message);
    } else {
      this.errors.push(e);
    }
    return console.log(e);
  }

  hasJavascriptErrors() {
    return this.error.length > 0;
  }
}

$(() => {
  this.pondoTesting = new PondoTesting(window);
  return this.pondoTesting.listen();
});


