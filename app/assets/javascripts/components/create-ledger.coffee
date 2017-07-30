app.modal "create-ledger"

pu.whenReady ->
  console.log 'hey'
  pu.eventDelegate 'mount', '.income', (e) ->
    console.log 'mounted'
    console.log e
