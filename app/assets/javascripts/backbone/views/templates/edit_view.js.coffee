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
    "blur textarea": "update"

  keymap: (e) ->
    switch e.which
      when 40 then @move(e)
      when 13 then @update(e)

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @$("textarea[name='title']").val()
    if @model.get('title') != title
      @model.save({ title: title },
        success: (template) => @model = template
      )
    @focus_next() if e.keyCode == 13

  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')

  render: ->
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description') }))
    return this