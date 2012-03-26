Actions.Views.Templates ||= {}

class Actions.Views.Templates.TemplateView extends Backbone.View
  template: JST["maven_tools/templates/templates/template"]

  events:
    "click .destroy" : "destroy"

  tagName: "li"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(this.el).html(@template(@model.toJSON()))
    return this