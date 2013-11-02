App.PagingMixin = Em.Mixin.create
  pageContent: (contentArray) ->
    page = @get('page') || 1
    perPage = @get('_perPage')
    len = contentArray.get 'length'

    start = (page-1) * perPage
    end = start + perPage

    if len <= start
      start = 0
      @set 'page', 1

    end = Math.min(len, start+perPage)

    pagedItems = contentArray.slice(start, end)

    @setProperties
      pageTotal: len
      pageStart: start+1
      pageEnd: end
      pageCount: ((len / perPage) >> 0) + (len % perPage > 0 ? 1 : 0)
      model: pagedItems
  actions:
    pageFirst: ->
      return if @get('page')==1
      @set 'page', 1
    pagePrevious: ->
      @set 'page', Math.max(1, @get('page')-1)
    pageNext: ->
      @set 'page', Math.min(@get('pageCount'), @get('page')+1)
    pageLast: ->
      return if @get('page')==@get('pageCount')
      @set 'page', @get('pageCount')

  _perPage: 100
  isFirstPage: ( ->
    @get('page') == 1
  ).property('page')
  isLastPage: ( ->
    @get('page') == @get('pageCount')
  ).property('page', 'pageLast', 'model')

