//= require backbone/mixins/movable
Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Backbone.View
  template: JST["backbone/templates/items/edit"]
  className: 'item'

  events:
    "keydown textarea[name='title']": "keymap"
    "blur textarea[name='title']": "update"

  keymap: (e) ->
    switch e.keyCode
      when 38, 40 then @move(e)
      when 8 then @destroy(e)
      when 13 then @update(e)

  move: Actions.Mixins.Movable['move']

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @$("textarea[name='title']").val()
    if @model.get('title') != title
      @model.save({ title: title },
        success : (item) =>
          @model = item
      )

  destroy: () ->
    if @$('textarea').val() == ''
      @model.destroy()
      $(@el).prev().find('textarea[name="title"]').focus()
      @remove()
      return false

  render: ->
    $(this.el).html(@template({ title: @model.get('title'), _id: @model.get('_id'), template_id: @options.template_id, subitemsCount: @options.subitemsCount}))
    return this