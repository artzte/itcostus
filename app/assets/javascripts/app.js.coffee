App.Router.map ->
  @resource "categories", {path: "/"}, ->
    @route 'show', {path: "/categories/:id"}
  @resource "matchers", {path: "/matchers"}, ->
    @route 'show', {path: "/matchers/:id"}


p1 = App.Category.fetch()
p2 = App.Matcher.fetch()

$.when(p1, p2).done ->
  Em.run.next ->
    p3 = App.Transaction.fetch()
    p3.then ->
      App.advanceReadiness()
