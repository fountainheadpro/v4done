Actions.Views.Templates ||= {}

class Actions.Views.Templates.EditView extends Backbone.View
  template: JST["backbone/templates/templates/edit"]
  className: 'template'

  events:
    "focusin textarea": "highlight"

  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')

  render: ->
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description') }))
    return this