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
      
  actions:
    tab: (activeTab) ->
      console.log activeTab
      @set 'tab', activeTab

  transactionsTabActive: ( ->
    tab = @get 'tab'
    if Em.isNone(tab) || tab == 'transactions'
      'active'
    else
      null
  ).property('tab')
  
  graphTabActive: ( ->
    tab = @get 'tab'
    if tab == 'graph'
      'active'
    else
      null
  ).property('tab')
