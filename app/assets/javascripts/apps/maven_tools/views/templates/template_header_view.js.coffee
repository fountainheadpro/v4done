Actions.Views.Templates ||= {}

class Actions.Views.Templates.TemplateHeaderEditView extends Actions.Views.Items.BaseItemView

  template: JST["apps/maven_tools/templates/templates/edit"]
  className: 'template'
  tagName: 'header'
  view_name: "template_header"


  events: Actions.Views.Items.BaseItemView::base_events

  save: (e)->
    super(e)




  render: ->
    $(@el).html(@template({ id: @model.id }))
    @title().val(@model.get('title'))
    @description().html( @model.get('description') )
    @description().action_editor()
    return this

