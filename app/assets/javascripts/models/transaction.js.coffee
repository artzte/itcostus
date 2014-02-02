App.Transaction = App.Model.extend
  id: Ember.attr()
  account: Ember.attr()
  posted_at: Ember.attr(Date)
  description: Ember.attr()
  amount: Ember.attr(Number)
  transaction_type: Ember.attr()
  note: Ember.attr()

  matcher: Ember.belongsTo 'App.Matcher',
    key: 'matcher_id'
  category: Ember.belongsTo 'App.Category',
    key: 'category_id'

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
  transactionType: (->
    @get('transaction_type')
    ).property('transaction_type')
  validate: ->
    @_super()

    category_id = @get('category_id')
    if Em.isNone(category_id) || category_id == 0
      @setError 'category_id'

    @get('matcher').validate()

    return Em.isEmpty(@get('errors')) && Em.isEmpty(@get('matcher.errors'))

App.Transaction.url = "/transactions"
App.Transaction.adapter = Ember.RESTAdapter.create()

