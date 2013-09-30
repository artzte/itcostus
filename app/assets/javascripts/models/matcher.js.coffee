App.Matcher = App.Model.extend
  id: Ember.attr()
  category: Ember.belongsTo 'App.Category',
    key: 'category_id'
  transactions: Ember.hasMany 'App.Transaction',
    key: 'matcher_id'
  words: Ember.attr()
  terms: ( (key, value) ->
    @get('words').split /\s+/
  ).property('words')
  validate: ->
    @clearErrors()
    if Em.isEmpty(@get('words').trim())
      @setError 'words'
      return false
    true

App.Matcher.url = "/matchers"
App.Matcher.adapter = Ember.RESTAdapter.create()