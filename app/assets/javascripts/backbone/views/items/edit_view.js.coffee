Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Backbone.View
  template: JST["backbone/templates/items/edit"]
  className: 'item'

  events:
    "keydown textarea[name='title']": "move"

  move: (e) ->
    if e.keyCode == 40 || e.keyCode == 38
      e.preventDefault()
      e.stopPropagation()
      textarea = $(@el).next().find('textarea[name="title"]') if e.keyCode == 40
      textarea = $(@el).prev().find('textarea[name="title"]') if e.keyCode == 38
      textarea.focus()

  render: ->
    $(this.el).html(@template(@model.toJSON()))
    return this