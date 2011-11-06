Actions.Views.Actions ||= {}

class Actions.Views.Actions.ActionView extends Backbone.View
  template: JST["backbone/templates/actions/action"]
  
  events:
    "click .destroy" : "destroy"
      
  tagName: "tr"
  
  destroy: () ->
    @model.destroy()
    this.remove()
    
    return false
    
  render: ->
    $(this.el).html(@template(@model.toJSON() ))    
    return this