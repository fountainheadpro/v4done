Actions.Views.Templates ||= {}

class Actions.Views.Templates.NewView extends Backbone.View
  template: JST["apps/maven_tools/templates/templates/new"]

  events:
    "submit #new-template": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    @collection.create(@model.toJSON(),
      wait: true,
      success: (template) =>
        @$('#title').val('')
        template.setItemsUrl()
        unless window.location.pathname.match?('templates')
          window.location="../templates/#"+ template.id + "/items"
        else
          Actions.router.navigate("#{template.id}/items", {trigger: true})

      error: (template, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(this.el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this