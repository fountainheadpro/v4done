//= require backbone/mixins/movable
Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Backbone.View
  template: JST["backbone/templates/items/edit"]
  className: 'item'

  events:
    "keydown textarea[name='title']": "move"

  move: Actions.Mixins.Movable['move']

  render: ->
    $(this.el).html(@template({ title: @model.get('title'), _id: @model.get('_id'), template_id: @options.template_id}))
    return this