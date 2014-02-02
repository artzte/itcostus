App.MatchersShowRoute = Em.Route.extend
  setupController: (controller, model) ->
    @_super controller, model
    @controllerFor('categories').set 'content', App.Category.findAll();
