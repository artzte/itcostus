App.Router.map ->
  @route "transactions", {path: "/"}
  @resource "categories", {path: "/categories"}, ->
    @route 'category', {path: ":id"}
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


p1 = App.Category.fetch()
p2 = App.Matcher.fetch()

$.when(p1, p2).done ->
  Em.run.next ->
    p3 = App.Transaction.fetch()
    p3.then ->
      App.advanceReadiness()
