App.PagedTransactionsController = Em.ArrayController.extend App.PagingMixin,
  needs: ['transactions', 'categories']
  itemController: 'transaction'
  perPage: 100
  setPageTransactions: (->
    Em.debug "setPageTransactions was called"
    transactions = @get 'controllers.transactions.model'
    unless transactions
      @set 'model', transactions
    else
      @pageContent transactions
    Em.run.scheduleOnce 'afterRender', @, ->
      @set 'loading', false
  ).observes('controllers.transactions.model.@each', 'page')
  dropped: ->
    dropSource = @get('controllers.categories.dragSource')
    console.log dropSource.get('name')
