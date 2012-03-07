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
    @options.items.byPreviousId(null).each (item) =>
      if !_.include(rendered, item.id)
        @addOne(item)
        rendered.push(item.id)
        while item = @options.items.get(item.get('next_id'))
          if !_.include(rendered, item.id)
            @addOne(item)
            rendered.push(item.id)


  addOne: (item) ->
    view = new Actions.Views.Items.EditView({ model: item, template: @options.template})
    $(@el).append(view.render().el)

  render: ->
    @addAll()

    return this