App.CategoriesShowController = Em.ObjectController.extend
  needs: ['transactions']

  syncTransactions: (->
    categoryTransactions = @get('model.transactions') 

    transactionsController = @get 'controllers.transactions'
    transactionsController.set 'model', categoryTransactions
    Em.debug "syncTransactions was called"
  ).observes('model.transactions.@each')
      
