Actions.Views.Items||= {}

class Actions.Views.Items.NewView extends Backbone.View
  template: JST["backbone/templates/items/new"]
  id: 'new-item'
  className: 'item'

  events:
    "keypress #new-item textarea[name='title']": "save"
    "keydown textarea[name='title']": "move"

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
          view = new Actions.Views.Items.EditView({ model: item })
          $(@el).before(view.render().el)
      )

  move: (e) ->
    if e.keyCode == 40 || e.keyCode == 38
      e.preventDefault()
      e.stopPropagation()
      textarea = $(@el).next().find('textarea[name="title"]') if e.keyCode == 40
      textarea = $(@el).prev().find('textarea[name="title"]') if e.keyCode == 38
      textarea.focus()

  render: ->
    $(@el).html(@template(@model.toJSON()))

    return this