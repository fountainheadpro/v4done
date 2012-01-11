Actions.Views.Breadcrumbs ||= {}

class Actions.Views.Breadcrumbs.IndexView extends Backbone.View
  tagName: "ul"
  className: "breadcrumb"

  initialize: () ->
    _.bindAll(this, 'addOne', 'render')

  addOne: (title, link, active = false) ->
    view = new Actions.Views.Breadcrumbs.BreadcrumbView({ title: title, link: link, active: active})
    $(@el).append(view.render().el)

  render: ->
    @addOne('Templates', '#/index', !@options.template?)
    if @options.template?
      @addOne(@options.template.get('title'), "#/#{@options.template.get('_id')}/items", !@options.item?)
      if @options.item?
        item = @options.item
        parent_items = while parent_id = item.get('parent_id')
          item = @options.template.items.get(parent_id)
          item
        for item in parent_items.reverse()
          @addOne(item.get('title'), "#/#{@options.template.get('_id')}/items/#{item.get('_id')}/items", false)
        @addOne(@options.item.get('title'), '', true)

    return this