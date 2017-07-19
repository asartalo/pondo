$document = $(document)

app.modal "create-ledger"

# app.hashChange "create-ledger",
#   ->
#     pu.selectAndEach '#create-ledger', (wrapper) ->
#       wrapper.classList.add('active')
#       pu.selectAndEach '#create-ledger .modal-content', (el) ->
#         pu.animateCss el, 'zoom-in'
#
#     pu.selectAndEach '#create-ledger a[href="#"]', (el) ->
#       cancel = el
#       app.showOverlay ->
#         cancel.click() if cancel
#
#
#   ->
#     pu.selectAndEach '#create-ledger .modal-content', (el) ->
#       pu.animateCss el, 'zoom-out', ->
#         el.parentElement.classList.remove('active')
#
#     app.hideOverlay()
