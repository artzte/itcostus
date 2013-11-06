App.CategoriesShowRoute = Em.Route.extend
  model: (params) ->
    App.Category.find(params.id)
  setupController: (controller, model) ->
    @_super controller, model
    @controllerFor('pagedTransactions').setProperties
      page: 1

  renderTemplate: ->
    @_super()
    @render 'transactions',
      into: 'categories.show'
      outlet: 'transactions'
      controller: @controllerFor('pagedTransactions')
