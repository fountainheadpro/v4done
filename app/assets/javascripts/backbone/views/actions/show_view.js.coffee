Actions.Views.Actions ||= {}

class Actions.Views.Actions.ShowView extends Backbone.View
  template: JST["backbone/templates/actions/show"]
   
  render: ->
    $(this.el).html(@template(@model.toJSON()))
    return this