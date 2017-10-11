app.modal "create-ledger"

pu.whenReady ->
  pu.eventDelegate 'mount', '.income', (e) ->
    console.log 'mounted'
    console.log e
