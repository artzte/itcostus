App.CategoriesController = Em.ArrayController.extend
  needs: ['transactions']
  userCategories: (->
    @get('model').filterBy('system_type', null)
  ).property('model.@each.system_type')
  unassigned: (->
    @get('model').findBy('system_type', 'unassigned')
  ).property('model')
