Actions.Views.Actions ||= {}

class Actions.Views.Actions.IndexView extends Backbone.View
  template: JST["backbone/templates/actions/index"]
    
  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    
    @options.actions.bind('reset', @addAll)
   
  addAll: () ->
    @options.actions.each(@addOne)
  
  addOne: (action) ->
    view = new Actions.Views.Actions.ActionView({model : action})
    @$("tbody").append(view.render().el)
       
  render: ->
    $(@el).html(@template({actions: @options.actions.toJSON()}))
    @addAll()
    
    return this