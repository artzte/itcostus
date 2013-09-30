App.Router.map ->
  @route "transactions", {path: "/"}
  @resource "categories", {path: "/categories"}
  @resource "matchers", {path: "/matchers"}

App.ProtoView = Em.View.extend
  layoutName: 'layout'
  didInsertElement: ->
    console.log "Inserted #{@}"
App.TransactionsView = App.ProtoView.extend
  templateName: 'transactions'

App.CategoriesView = App.ProtoView.extend
  templateName: 'categories'
App.MatchersView = App.ProtoView.extend
  templateName: 'matchers'

App.CategorySelect = Em.Select.extend
  classNames: ['transaction-category']
  prompt: 'Uncategorized'

 # contentBinding="categoryOptions" valueBinding="category_id" optionLabelPath='content.name' optionValuePath='content.id' classBinding=".transaction-category"

App.TransactionListItemView = Ember.ListItemView.extend
  templateName: "transaction-row"
  categoryName: (->
    @get('controller.category.name') || 'Uncategorized'
  ).property('controller.category')
  keydown: (event) ->
    if(event.which==13)
      @monkeyPatchInputs()
    console.log "keydown"
  change: (event) ->
    @monkeyPatchInputs()
    console.log "change"

  # something is wrong with the virtual list box
  monkeyPatchInputs: ->
    val = @$().find('input').val()
    @set('controller.model.matcher.words', val)

App.TransactionListView = Ember.ListView.extend
  itemViewClass: App.TransactionListItemView

App.CategoriesRoute = Em.Route.extend
  model: ->
    App.Category.findAll()
App.TransactionsRoute = Em.Route.extend
  model: ->
    App.Transaction.findAll()
  setupController: (controller, model) ->
    @_super(controller, model)
    controller.notifyPropertyChange 'selectedCategoryId'


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

App.CategoriesController = Em.ArrayController.extend()

p1 = App.Category.fetch()
p2 = App.Matcher.fetch()

$.when(p1, p2).done ->
  Em.run.next ->
    p3 = App.Transaction.fetch()
    p3.then ->
      App.advanceReadiness()
