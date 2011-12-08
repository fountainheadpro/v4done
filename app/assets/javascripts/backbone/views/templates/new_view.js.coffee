Actions.Views.Templates ||= {}

class Actions.Views.Templates.NewView extends Backbone.View
  template: JST["backbone/templates/templates/new"]

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
    m = @model.toJSON()
    @collection.create(@model.toJSON(),
      success: (template) =>
        @$('#title').val('')

      error: (template, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(this.el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this