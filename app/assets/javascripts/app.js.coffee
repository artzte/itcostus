App.Router.map ->
  @resource "categories", {path: "/"}, ->
    @route 'show', {path: "/categories/:id"}
  @resource "matchers", {path: "/matchers"}, ->
    @route 'show', {path: "/matchers/:id"}


p1 = App.Category.fetch()
p2 = App.Matcher.fetch()

Ember.RSVP.all([p1, p2]).then ->
  App.advanceReadiness()
