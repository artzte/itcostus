App.CategoriesController = Em.ArrayController.extend
  init: ->
  	@_super()
  	@set 'content', App.Category.findAll()
  userCategories: (->
    @get('content').filterBy('system_type', null)
  ).property('content.@each.system_type')
