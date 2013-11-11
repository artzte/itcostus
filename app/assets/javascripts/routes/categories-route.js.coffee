App.CategoriesRoute = Em.Route.extend
  model: ->
    App.Category.findAll()
  setupController: (controller, model) ->
    @_super controller, model
    unassigned = controller.get 'unassigned'
    @controllerFor('categoriesShow').set('model', unassigned)
    @controllerFor('transactions').setProperties
      page: 1

  renderTemplate: ->
    @render 'categories',
      controller: @controllerFor('categories')
    @render 'categories.show',
      into: 'categories'
      controller: @controllerFor('categoriesShow')
    @render 'transactions',
      into: 'categories.show'
      outlet: 'transactions'
      controller: @controllerFor('transactions')
