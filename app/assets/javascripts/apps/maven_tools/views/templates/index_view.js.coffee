Actions.Views.Templates ||= {}

class Actions.Views.Templates.IndexView extends Backbone.View
  tagName: "ul"
  className: "unstyled"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')

    @options.templates.bind('reset', @addAll)
    @options.templates.bind('add',   @addOne)

  addAll: () ->
    @options.templates.each(@addOne)

  addOne: (template) ->
    view = new Actions.Views.Templates.TemplateView({ model: template })
    $(@el).prepend(view.render().el)

  render: ->
    @addAll()

    return this