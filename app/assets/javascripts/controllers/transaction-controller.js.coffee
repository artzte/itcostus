App.TransactionsController = Em.ArrayController.extend
  itemController: 'transaction'
  categoryOptions: (->
    App.Category.findAll()
  ).property()
  filterList: (->
    categoryId = @get 'selectedCategoryId'
    if Em.isNone(categoryId)
      categoryId = null
    @set 'model', App.Transaction.findAll().filterBy('category_id', categoryId)
  ).observes('selectedCategoryId')


App.TransactionController = Em.ObjectController.extend
  needs: ['categories', 'transactions']
  setEdit: ->
    txn = @get 'model'
    @set 'isEditing', true
    unless txn.get('matcher')
      matcher = App.Matcher.create
        words: txn.get('terms').join(' ')
      txn.set 'matcher', matcher        
  save: ->
    debugger
    txn = @get 'model'
    return unless txn.validate()
    promise = txn.save()
    promise.then ->
      @closeEditor()
  cancel: ->
    @closeEditor()
  closeEditor: ->
    @set 'isEditing', false

