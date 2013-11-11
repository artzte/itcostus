App.PagingMixin = Em.Mixin.create
  paginatedContent: (->
    page = @get('page') || 1
    perPage = @get('perPage')
    len = @get 'length'

    start = (page-1) * perPage
    end = start + perPage

    console.log "pC", @, len

    if len <= start
      start = 0
      @set 'page', 1

    end = Math.min(len, start+perPage)

    pagedItems = @slice(start, end)

    @setProperties
      pageStart: start+1
      pageEnd: end

    pagedItems
  ).property('length', 'page')

  pageCount: ( ->
    len = @get 'length'
    perPage = @get 'perPage'

    count = ((len / perPage) >> 0)

    # remainder present?
    if (len % perPage) > 0
      count += 1

    count
  ).property('length', 'perPage')

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

  perPage: 100
  isFirstPage: ( ->
    @get('page') == 1
  ).property('page')
  isLastPage: ( ->
    @get('page') == @get('pageCount')
  ).property('page', 'pageCount')

