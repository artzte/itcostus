App.MatchersRoute = Em.Route.extend
  model: ->
    App.Matcher.findAll()
  setupController: (controller, model) ->
    @_super controller, model
    @controllerFor('categories').set 'content', App.Category.findAll();
