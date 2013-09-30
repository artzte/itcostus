App = Ember.Application.create()

window.App = App

App.deferReadiness()

App.Model = Ember.Model.extend
  setError: (attribute, description = 'error') ->
    @set 'errors', {} if Em.isNone @get('errors')
    @set "errors.#{attribute}", description
  clearErrors: ->
    @set 'errors', null
  validate: ->
    @clearErrors()
    true

