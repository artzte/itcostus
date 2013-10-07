App.TransactionsController = Em.ArrayController.extend
  needs: ['categories']
  itemController: 'transaction'
  categoryOptions: (->
    @get 'controllers.categories.userCategories'
  ).property('controllers.categories.userCategories')
  filteredList: (->
    category_id = @get 'selectedCategory.id'
    if Em.isNone(category_id)
      category_id = null
    @get('content').filterBy('category_id', category_id)
  ).property('selectedCategory', 'content.@each.category_id')

