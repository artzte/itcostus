App.CategoriesShowController = Em.ObjectController.extend
  needs: ['transactions']

  syncTransactions: (->
    category = @get('model')
    return unless category

    transactionsController = @get 'controllers.transactions'
    promise = category.reload()
    promise.then ->
      transactionsController.set 'model', category.get('transactions')
  ).observes('model')
      
