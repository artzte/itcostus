App.CategoriesShowRoute = Em.Route.extend
  model: (params) ->
    App.Category.find(params.id)
  setupController: (controller, model) ->
    @_super controller, model
    transactionsController = @controllerFor('transactions')

    model.reload().then ->
      transactionsController.setProperties
        model: model.get('transactions')
        page: 1

  renderTemplate: ->
    @_super()
    @render 'transactions',
      into: 'categories.show'
      outlet: 'transactions'
      controller: @controllerFor('transactions')
