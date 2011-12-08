Actions.Views.Templates ||= {}

class Actions.Views.Templates.IndexView extends Backbone.View
  template: JST["backbone/templates/templates/index"]

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')

    @options.templates.bind('reset', @addAll)
    @options.templates.bind('add',   @addOne)

  addAll: () ->
    @options.templates.each(@addOne)

  addOne: (template) ->
    view = new Actions.Views.Templates.TemplateView({model : template})
    @$("#templates_list").append(view.render().el)

  render: ->
    $(@el).html(@template(templates: @options.templates.toJSON() ))
    @addAll()

    return this