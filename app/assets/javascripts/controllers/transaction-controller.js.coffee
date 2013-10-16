App.TransactionController = Em.ObjectController.extend
  needs: ['categories', 'transactions']
  actions:
    setEdit: ->
      txn = @get 'model'
      @set 'isEditing', true
      unless txn.get('matcher')
        matcher = App.Matcher.create
          words: txn.get('terms').join(' ')
        txn.set 'matcher', matcher
    save: ->
      matcher = @get 'model.matcher'
      return unless matcher.validate()
      promise = matcher.save()
      my = @
      promise.then ->
        my.closeEditor()
        # reload the unassigned pool
        matcher.get('category').reload()
        unassigned = my.get('controllers.categories.unassigned')
        unassigned.reload()
    cancel: ->
      @closeEditor()
  userCategories: (->
    userCategories = @get 'controllers.categories.userCategories'
    userCategories
    ).property('controllers.categories.userCategories')
  closeEditor: ->
    @set 'isEditing', false
