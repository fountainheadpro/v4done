Actions.Views.Templates ||= {}

class Actions.Views.Templates.EditView extends Backbone.View
  template: JST["apps/maven_tools/templates/templates/edit"]
  className: 'template'
  tagName: 'header'

  move: Actions.Mixins.Movable['move']
  focus_next: Actions.Mixins.Movable['focus_next']
  focus_prev: Actions.Mixins.Movable['focus_prev']

  events:
    "focusin textarea" : "highlight"
    "keydown textarea" : "keymap"
    "keydown div[name='description']" : "keymap"
    "blur textarea"    : "update"
    "blur div[name='description']"    : "update"
    "click button"     : "publish"
    #"keyup div[name='description']" : "resizeTextarea"

  keymap: (e) ->
    if e.target.name == 'title'
      switch e.which
        when 38, 40 then @move(e)
        when 13 then @update(e)
    else if e.target.name == 'description'
      switch e.which
        when 38 then @move(e) if Actions.Mixins.CarerPosition.atFirstLine(e.target)
        when 40 then @move(e) if Actions.Mixins.CarerPosition.atLastLine(e.target)


  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @$("textarea[name='title']").val()
    description = @$("div[name='description']").html()
    if @model.get('title') != title || @model.get('description') != description
      @model.save({ title: title, description: description },
        success: (template) => @model = template
      )
    @focus_next() if e.keyCode == 13

  highlight: ->
    $('.selected div[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    #$('.selected').removeClass('selected')
    $('.selected').addClass('selected')
    @$('.description').show()
    #@$('#description').show()
    #@resizeTextarea(@$("textarea[name='description']")[0])

  publish: ->
    $.post "/templates/#{@model.id}/publications.json", (data) ->
      if data._id
        window.location.replace("/publications/#{data._id}")

  render: ->
    $(@el).html(@template({ id: @model.id, title: @model.get('title'), description: @model.get('description') }))
    return this