App.CategoriesShowController = Em.ObjectController.extend
  needs: ['transactions']

  syncTransactions: (->
    category = @get('model')
    return unless category

    transactionsController = @get 'controllers.transactions'
    category.set 'isLoaded', false
    promise = App.Category.fetch(category.get('id'))
    promise.then ->
      transactionsController.set 'model', category.get('transactions')
      console.log "transactions received", category.get('transactions.length')
    console.log "sync called", category.get('name')
  ).observes('model')
      
