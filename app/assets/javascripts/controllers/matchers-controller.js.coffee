App.MatchersController = Em.ArrayController.extend
  itemController: 'matcher'
  actions:
    rerun: ->
      @set 'isLoading', true
      promise = $.ajax
        method: 'post'
        url: '/matchers/rerun'
        context: @
      promise.then ->
        @set 'isLoading', false
        console.log "done rerun"
