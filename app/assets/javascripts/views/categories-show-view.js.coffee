App.CategorySelect = Em.Select.extend
  classNames: ['transaction-category', 'form-control']
  prompt: 'Uncategorized'

App.MatcherCategorySelect = Em.Select.extend
  classNames: ['matcher-category', 'form-control']



Em.Handlebars.helper "formatMonth", (date) ->
  "#{date.getFullYear()}/#{date.getMonth()+1}"

App.CategoryMonthsBarComponent = Em.Component.extend
  update: (->
    monthlySummary = @get 'monthlySummary'
    return unless monthlySummary.get('length') > 0
    @$('.chart').empty()

    # @drawChart()

    barchart = d3.select('.chart')
      .append('svg')
      .attr('height', 200)
      .attr('width', 800)
      .chart('BarChart')

    barchart.draw monthlySummary.map (m) ->
      name: "#{m.date.getFullYear()}-#{m.date.getMonth()+1}"
      value: m.amount*-1

  ).observes('monthlySummary')

