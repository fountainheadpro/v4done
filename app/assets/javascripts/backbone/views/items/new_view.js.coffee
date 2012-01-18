//= require backbone/mixins/movable
Actions.Views.Items||= {}

class Actions.Views.Items.NewView extends Backbone.View
  template: JST["backbone/templates/items/new"]
  className: 'item new_item'

  move: Actions.Mixins.Movable['move']

  events:
    "keydown textarea[name='title']": "keymap"

  constructor: (options) ->
    super(options)

  keymap: (e) ->
    switch e.keyCode
      when 38, 40 then @move(e)
      when 8 then @destroy(e)
      when 13 then @save(e)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    title = @$("textarea[name='title']").val()
    parentId = @options.parentItem.get('_id') if @options.parentItem?
    @options.template.items.create({ title: title, parent_id: parentId },
      success: (item) =>
        @$('textarea[name="title"]').val('')
        view = new Actions.Views.Items.EditView({ model: item, template: @options.template, subitemsCount: 0 })
        $(@el).before(view.render().el)
    )

  destroy: () ->
    if @$('textarea').val() == ''
      $(@el).prev().find('textarea[name="title"]').focus()
      @remove()
      return false

  render: ->
    $(@el).html(@template())

    return this