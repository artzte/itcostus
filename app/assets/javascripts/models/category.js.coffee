App.Category = App.Model.extend
  id: Ember.attr()
  name: Ember.attr()
  count: Ember.attr(Number)
  total: Ember.attr(Number)
  transactions: Ember.hasMany 'App.Transaction',
    key: 'transaction_ids'
  matchers: Ember.hasMany 'App.Matcher',
    key: 'matcher_id'
App.Category.url = "/categories"
App.Category.adapter = Ember.RESTAdapter.create()
