Actions.Views.Actions ||= {}

class Actions.Views.Actions.NewView extends Backbone.View    
  template: JST["backbone/templates/actions/new"]
  
  events:
    "submit #new-action": "save"
    
  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )
    
  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
      
    @model.unset("errors")
    
    @collection.create(@model.toJSON(), 
      success: (action) =>
        @model = action
        window.location.hash = "/#{@model.id}"
        
      error: (action, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
    
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)
    
    return this