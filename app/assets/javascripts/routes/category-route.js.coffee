App.CategoryRoute = Em.Route.extend
  model: ->
    App.Transaction.findAll()
  setupController: (controller, model) ->
    @_super(controller, model)
    controller.notifyPropertyChange 'selectedCategoryId'
