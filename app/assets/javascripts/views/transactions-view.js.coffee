App.TransactionsView = Em.View.extend DragDrop.Droppable,
  templateName: 'transactions/transactions'
  drop: (event) ->
    @get('controller').dropped()
