Actions.Views.Items ||= {}

class Actions.Views.Items.ItemView extends Backbone.View
  template: JST["backbone/templates/items/item"]
  className: 'item'

  render: ->
    $(this.el).html(@template(@model.toJSON()))
    return this