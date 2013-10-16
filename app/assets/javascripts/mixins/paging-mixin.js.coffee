App.PagingMixin = Em.Mixin.create
  pageContent: (contentArray) ->
    page = @get('page') || 1
    perPage = @get('perPage') || 100
    len = contentArray.get 'length'

    start = (page-1) * perPage
    end = start + perPage

    if len <= start
      start = 0
      @set 'page', 1

    end = Math.min(len, start+perPage)

    pagedItems = contentArray.slice(start, end)
    Ember.debug "setting properties on #{@}"
    Ember.debug "new content length is #{pagedItems.get('length')}"

    @setProperties
      pageTotal: len
      pageStart: start
      pageEnd: end
      model: pagedItems
