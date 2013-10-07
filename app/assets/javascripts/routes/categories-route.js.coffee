App.CategoriesRoute = Em.Route.extend
  model: ->
    App.Category.findAll()
