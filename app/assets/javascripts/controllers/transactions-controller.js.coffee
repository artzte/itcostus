App.TransactionsController = Em.ArrayController.extend
  needs: ['transactions', 'categories']
  itemController: 'transaction'
  init: ->
    @_super()
  dropped: ->
    category = @get('controllers.categories.dragSource')
    selections = @get('model').filterProperty 'selected'
    promise = App.Matcher.bulkSave category, selections
    my = @
    promise.then ->
      category.reload()
      my.get('controllers.categories.unassigned').reload()
