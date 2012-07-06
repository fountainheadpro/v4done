Actions.Views.Templates ||= {}

class Actions.Views.Templates.TemplateHeaderEditView extends Actions.Views.Items.BaseItemView

  template: JST["apps/maven_tools/templates/templates/edit"]
  className: 'template'
  tagName: 'header'
  view_name: "template_header"

  child_events:
    'click button': "publish"


  events: _.extend(_.clone(Actions.Views.Items.BaseItemView::base_events), TemplateHeaderEditView::child_events)

  keymap: (e)->
    if e.shiftKey && e.which == 13
      @expand_description(e)
    if e.which == 13 && !e.shiftKey
      @container.$el.trigger({type: "next_item"})
    super(e)

  render: ->
    $(@el).html(@template({ id: @model.id }))
    @title().val(@model.get('title'))
    @description().html( @model.get('description') )
    @description().action_editor()
    return this

  publish: ->
    $.post "/templates/#{@model.id}/publications.json", (data) ->
      if data._id
        window.location.replace("/publications/#{data._id}")

