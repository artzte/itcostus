App.TransactionsController = Em.ArrayController.extend App.PagingMixin,
  needs: ['categories']
  perPage: 100
  itemController: 'transaction'
  sortProperties: ['posted_at']
  sortAscending: false
  init: ->
    @_super()
  actions:
    sort: (field) ->
      @setProperties
        sortProperties: [field]
  dropped: ->
    category = @get('controllers.categories.dragSource')
    selections = @get('model').filterProperty 'selected'
    promise = App.Matcher.bulkSave category, selections
    my = @
    promise.then ->
      category.reload()
      my.get('controllers.categories.unassigned').reload()
