Actions.Views.Actions ||= {}

class Actions.Views.Actions.EditView extends Backbone.View
  template : JST["backbone/templates/actions/edit"]
  
  events :
    "submit #edit-action" : "update"
    
  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @model.save(null,
      success : (action) =>
        @model = action
        window.location.hash = "/#{@model.id}"
    )
    
  render : ->
    $(this.el).html(this.template(@model.toJSON()))
    
    this.$("form").backboneLink(@model)
    
    return this