Actions.Views.Items||= {}

class Actions.Views.Items.NewView extends Backbone.View
  template: JST["backbone/templates/items/new"]
  id: 'new-item'
  className: 'item'

  events:
    "keypress #new-item textarea[name='title']": "save"

  constructor: (options) ->
    super(options)
    @model = new @options.template.items.model()

  save: (e) ->
    if (e.keyCode == 13)
      e.preventDefault()
      e.stopPropagation()

      title = @$("textarea[name='title']").val()
      @options.template.items.create(title: title,
        success: (item) =>
          @$('textarea[name="title"]').val('')
          view = new Actions.Views.Items.ItemView({ model: item })
          $(@el).before(view.render().el)
      )

  render: ->
    $(@el).html(@template(@model.toJSON()))

    return this