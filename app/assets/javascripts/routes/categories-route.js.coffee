App.CategoriesRoute = Em.Route.extend
  model: ->
    App.Category.findAll()
  setupController: (controller, model) ->
    @_super controller, model
    @set 'unassigned', model.findBy('system_type', 'unassigned')
