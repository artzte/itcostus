App.Category = App.Model.extend
  id: Ember.attr()
  name: Ember.attr()
  system_type: Ember.attr()
  count: Ember.attr(Number)
  total: Ember.attr(Number)
  matchers: Ember.hasMany 'App.Matcher',
    key: 'matcher_ids'
  transactions: Ember.hasMany 'App.Transaction',
    key: 'transaction_ids'
App.Category.url = "/categories"
App.Category.adapter = Ember.RESTAdapter.create()