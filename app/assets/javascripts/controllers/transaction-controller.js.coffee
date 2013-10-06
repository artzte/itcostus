App.TransactionsController = Em.ArrayController.extend
  needs: ['categories']
  itemController: 'transaction'
  categoryOptions: (->
    @get 'controllers.categories.userCategories'
  ).property('controllers.categories.userCategories')
  filterList: (->
    categoryId = @get 'selectedCategoryId'
    if Em.isNone(categoryId)
      categoryId = null
    @set 'model', App.Transaction.findAll().filterBy('category_id', categoryId)
  ).observes('selectedCategoryId')


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
    cancel: ->
      @closeEditor()
  closeEditor: ->
    @set 'isEditing', false

