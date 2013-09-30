App.Transaction = App.Model.extend
  id: Ember.attr()
  _transaction_date: Ember.attr(Date)
  _description: Ember.attr()
  _transtype: Ember.attr()
  _amount: Ember.attr(Number)
  _transaction_id: Ember.attr()
  account: Ember.attr()
  posted_at: Ember.attr(Date)
  description: Ember.attr()
  amount: Ember.attr(Number)
  category_id: Ember.attr(Number)
  category: Ember.belongsTo 'App.Category',
    key: 'category_id'
  matcher: Ember.belongsTo 'App.Matcher',
    key: 'matcher_id'
  matched: (->
    !Em.isNone @get('matcher.id')
  ).property('matcher.id')
  transaction_type: Ember.attr()
  amountString: (->
    @get('amount').toFixed(2)
  ).property('amount')
  terms: (->
    words = @get('description')||''
    words.split /\s+/
  ).property('description')
  postedAt: (->
    date = moment @get('posted_at')
    date.format("L")
  ).property('posted_at')
  validate: ->
    @_super()

    category_id = @get('category_id')
    if Em.isNone(category_id) || category_id == 0
      @setError 'category_id'

    @get('matcher').validate()

    return Em.isEmpty(@get('errors')) && Em.isEmpty(@get('matcher.errors'))

App.Transaction.url = "/transactions"
App.Transaction.adapter = Ember.RESTAdapter.create()

