Actions.Views.Templates ||= {}

class Actions.Views.Templates.EditView extends Backbone.View
  template: JST["backbone/templates/templates/edit"]
  className: 'template'

  move: Actions.Mixins.Movable['move']
  focus_next: Actions.Mixins.Movable['focus_next']
  focus_prev: Actions.Mixins.Movable['focus_prev']

  events:
    "focusin textarea": "highlight"
    "keydown textarea": "keymap"

  keymap: (e) ->
    switch e.which
      when 40 then @move(e)

  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')

  render: ->
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description') }))
    return this