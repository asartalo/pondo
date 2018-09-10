import app from '../app';

app.modal("create-ledger");

pu.whenReady(() =>
  pu.eventDelegate('mount', '.income', function(e) {
    console.log('mounted');
    return console.log(e);
  })
);

