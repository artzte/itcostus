App.CategoriesRoute = Em.Route.extend
  model: ->
    App.Category.findAll()
  setupController: (controller, model) ->
    @_super controller, model
    unassigned = model.findBy('system_type', 'unassigned')
    @controllerFor('categoriesShow').set('model', unassigned)
    @controllerFor('pagedTransactions').setProperties
      page: 1
      loading: true

  renderTemplate: ->
    @render 'categories',
      controller: @controllerFor('categories')
    @render 'categories.show',
      into: 'categories'
      controller: @controllerFor('categoriesShow')
    @render 'transactions',
      into: 'categories.show'
      outlet: 'transactions'
      controller: @controllerFor('pagedTransactions')
