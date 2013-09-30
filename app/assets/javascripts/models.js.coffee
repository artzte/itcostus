attr = Ember.attr

App.Model = Ember.Model.extend
  setError: (attribute, description = 'error') ->
    @set 'errors', {} if Em.isNone @get('errors')
    @set "errors.#{attribute}", description
  clearErrors: ->
    @set 'errors', null
  validate: ->
    @clearErrors()
    true

App.Category = App.Model.extend
  id: attr()
  name: attr()
  count: attr(Number)
  total: attr(Number)
  transactions: Ember.hasMany 'App.Transaction',
    key: 'transaction_ids'
  matchers: Ember.hasMany 'App.Matcher',
    key: 'matcher_id'
App.Category.url = "/categories"
App.Category.adapter = Ember.RESTAdapter.create()

App.Transaction = App.Model.extend
  id: attr()
  _transaction_date: attr(Date)
  _description: attr()
  _transtype: attr()
  _amount: attr(Number)
  _transaction_id: attr()
  account: attr()
  posted_at: attr(Date)
  description: attr()
  amount: attr(Number)
  category_id: attr(Number)
  category: Ember.belongsTo 'App.Category',
    key: 'category_id'
  matcher: Ember.belongsTo 'App.Matcher',
    key: 'matcher_id'
  matched: (->
    !Em.isNone @get('matcher.id')
  ).property('matcher.id')
  transaction_type: attr()
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

App.Matcher = App.Model.extend
  id: attr()
  category: Ember.belongsTo 'App.Category',
    key: 'category_id'
  transactions: Ember.hasMany 'App.Transaction',
    key: 'matcher_id'
  words: attr()
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

