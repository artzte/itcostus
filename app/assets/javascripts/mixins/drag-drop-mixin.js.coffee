window.DragDrop = Ember.Namespace.create()

DragDrop.cancel = (event) ->
  event.preventDefault()
  false

DragDrop.Draggable = Ember.Mixin.create
  attributeBindings: 'draggable'
  draggable: 'true'
  dragStart: (event) ->
    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setData 'Text', this.get('elementId')

DragDrop.Droppable = Ember.Mixin.create
  dragEnter: DragDrop.cancel
  dragOver: DragDrop.cancel
  drop: (event) ->
    viewId = event.originalEvent.dataTransfer.getData('Text')
    Ember.View.views[viewId].destroy()
    event.preventDefault()
    return false
