Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Backbone.View
  template: JST["backbone/templates/items/edit"]
  className: 'item'

  render: ->
    $(this.el).html(@template(@model.toJSON()))
    return this