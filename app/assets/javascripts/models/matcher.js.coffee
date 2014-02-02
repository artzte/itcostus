App.Matcher = App.Model.extend
  id: Ember.attr()
  words: Ember.attr()

  category: Ember.belongsTo 'App.Category',
    key: 'category_id'
  transactions: Ember.hasMany 'App.Transaction',
    key: 'transaction_ids'

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
App.Matcher.bulkSave = (category, transactions) ->
    promise = Em.$.ajax
      url: "/matchers/match_transactions"
      data:
        matcher:
          category_id: category.get('id')
          transaction_ids: transactions.getEach 'id'
      type: 'post'
    transactions.setEach 'selected', false
    promise