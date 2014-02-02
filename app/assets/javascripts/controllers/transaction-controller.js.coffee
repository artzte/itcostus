App.TransactionController = Em.ObjectController.extend
  needs: ['categories', 'transactions', 'categoriesShow']
  actions:
    setEdit: ->
      txn = @get 'model'
      @set 'isEditing', true
      unless txn.get('matcher')
        matcher = App.Matcher.create
          words: txn.get('terms').join(' ')
        txn.set 'matcher', matcher
    save: ->
      matcher = @get 'content.matcher'
      transaction = @get 'content.model'
      return unless matcher.validate()
      p1 = matcher.save()
      p2 = transaction.save()
      my = @
      Em.RSVP.all([p1,p2]).then ->
        my.closeEditor()
        # reload the unassigned pool
        matcher.get('category').reload()
        unassigned = my.get('controllers.categories.unassigned')
        unassigned.reload()
        category = @get('controllers.categoriesShow.model').reload()
        if category != unassigned
          category.reload()
        
    cancel: ->
      @closeEditor()
  closeEditor: ->
    @set 'isEditing', false
