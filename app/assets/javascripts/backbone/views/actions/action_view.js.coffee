Actions.Views.Actions ||= {}

class Actions.Views.Actions.ActionView extends Backbone.View
  template: JST["backbone/templates/actions/action"]
  
  events:
    "click .destroy"  : "destroy"
    "keydown .title" : "move"

  tagName: "tr"
  
  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  move: (e) ->
   if e.keyCode==40
    id = @model.collection.at(@model.collection.indexOf(@model)+1).id
    $('#title_'+id).focus()
   if e.keyCode==38
    id = @model.collection.at(@model.collection.indexOf(@model)-1).id
    $('#title_'+id).focus()
   return


  render: ->
    $(this.el).html(@template(@model.toJSON()))
    return this