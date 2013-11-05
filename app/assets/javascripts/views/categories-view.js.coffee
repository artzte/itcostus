App.CategoriesView = App.IndexView.extend
  templateName: 'categories/index'
App.CategoriesIndexItem = Em.View.extend DragDrop.Draggable,
  templateName: 'categories/index-item'
  dragStart: ->
    @get('controller').setDragSource()
