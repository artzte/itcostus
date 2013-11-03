App.Category = App.Model.extend
  id: Ember.attr()
  name: Ember.attr()
  system_type: Ember.attr()
  count: Ember.attr(Number)
  total: Ember.attr(Number)
  matchers: Ember.hasMany 'App.Matcher',
    key: 'matcher_ids'
  transactions: Ember.hasMany 'App.Transaction',
    key: 'transactions'
    embedded: true
  monthlySummary: ( ->
    transactions = @get('transactions')
    summary = {}
    transactions.forEach (t) ->
      date = t.get('posted_at')
      date = new Date(date.getFullYear(), date.getMonth())
      key = date.getTime()
      amount = t.get('amount')
      if summary[key]
        summary[key].count += 1
        summary[key].amount += amount
      else
        summary[key] =
          count: 1
          amount: amount
          date: new Date(date.getFullYear(), date.getMonth())
          key: key
    months = []
    for key,value of summary
      months.push(value)
      value.amount = Math.round(value.amount, 2)
    months.sort (m1,m2) ->
      m1.key - m2.key
    months
  ).property('transactions.length')
App.Category.url = "/categories"
App.Category.adapter = Ember.RESTAdapter.create()