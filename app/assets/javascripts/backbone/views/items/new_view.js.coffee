//= require backbone/mixins/movable
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

  save: (e) ->
    if (e.keyCode == 13)
      e.preventDefault()
      e.stopPropagation()

      title = @$("textarea[name='title']").val()
      parentId = @options.parentItem.get('_id') if @options.parentItem?
      @options.template.items.create({ title: title, parent_id: parentId },
        success: (item) =>
          @$('textarea[name="title"]').val('')
          view = new Actions.Views.Items.EditView({ model: item, template_id: @options.template.get('_id') })
          $(@el).before(view.render().el)
      )

  move: Actions.Mixins.Movable['move']

  render: ->
    $(@el).html(@template())

    return this