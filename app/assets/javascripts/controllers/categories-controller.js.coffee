App.CategoriesController = Em.ArrayController.extend
  needs: ['transactions']
  itemController: 'category'
  userCategories: (->
    @get('model').filterBy('system_type', null)
  ).property('model.@each.system_type')
  unassigned: (->
    @get('model').findBy('system_type', 'unassigned')
  ).property('model')
  sortProperties: ['weight']
  sortAscending: false
App.CategoryController = Em.ObjectController.extend
  needs: ['categories']
  actions:
    navTo: ->
      @transitionToRoute 'categories.show', @get('model')
  setDragSource: ->
    @set 'controllers.categories.dragSource', @get('model')

