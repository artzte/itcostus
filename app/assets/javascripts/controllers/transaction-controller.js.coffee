App.TransactionsController = Em.ArrayController.extend
  needs: ['categories']
  itemController: 'transaction'
  categoryOptions: (->
    @get 'controllers.categories.userCategories'
  ).property('controllers.categories.userCategories')
  filteredList: (->
    category_id = @get 'selectedCategory.id'
    if Em.isNone(category_id)
      category_id = null
    @get('content').filterBy('category_id', category_id)
  ).property('selectedCategory', 'content.@each.category_id')

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

