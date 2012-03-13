Actions.Views.Items ||= {}

class Actions.Views.Items.IndexView extends Backbone.View
  tagName: "div"
  id: "items"
  className: "row"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')

    @options.items.bind('reset', @addAll)

  addAll: () ->
    rendered = []
    itemsCount = @options.items.length
    @options.items.byPreviousId(null).each (item) =>
      if !_.include(rendered, item.get('_id'))
        @addOne(item)
        rendered.push(item.get('_id'))
        item = @options.items.byPreviousId(item.get('_id')).first()
        i = 0
        while item? && i != itemsCount
          i = i + 1
          if !_.include(rendered, item.get('_id'))
            @addOne(item)
            rendered.push(item.get('_id'))
          item = @options.items.byPreviousId(item.get('_id')).first()
    if itemsCount != rendered.length
      @options.items.each (item) =>
        if !_.include(rendered, item.get('_id'))
          @addOne(item)
          rendered.push(item.get('_id'))


  addOne: (item) ->
    view = new Actions.Views.Items.EditView({ model: item, template: @options.template})
    $(@el).append(view.render().el)

  render: ->
    @addAll()

    return this