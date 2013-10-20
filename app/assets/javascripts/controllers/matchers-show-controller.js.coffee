App.MatchersShowController = Em.ObjectController.extend
  needs: ['transactions']
  syncTransactions: (->
    categoryTransactions = @get('model.transactions') 

    transactionsController = @get 'controllers.transactions'
    transactionsController.set 'model', categoryTransactions
    Em.debug "#{this} syncTransactions was called"
  ).observes('model.transactions.@each')
 App.MatcherController = Em.ObjectController.extend
  needs: ['transactions', 'categories']
  actions: 
    setEdit: ->
      editing = @get('isEditing')
      if editing
        @get('model').revert()
      @set 'isEditing', !editing
    delete: ->
      @destroy()
    save: ->
      promise = @get('content').save()
      my = @
      promise.then ->
        my.set 'isEditing', false
        
