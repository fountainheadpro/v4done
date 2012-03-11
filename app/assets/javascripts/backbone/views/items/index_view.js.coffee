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
      if !_.include(rendered, item.get('_id'))
        @addOne(item)
        rendered.push(item.get('_id'))
        @options.items.byPreviousId(item.get('_id')).each (next_item) =>
          if !_.include(rendered, next_item.get('_id'))
            @addOne(next_item)
            rendered.push(next_item.get('_id'))


  addOne: (item) ->
    view = new Actions.Views.Items.EditView({ model: item, template: @options.template})
    $(@el).append(view.render().el)

  render: ->
    @addAll()

    return this