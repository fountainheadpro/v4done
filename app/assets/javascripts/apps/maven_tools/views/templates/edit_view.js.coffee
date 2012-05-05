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
    "blur textarea"    : "update"
    "click button"     : "publish"
    "keyup textarea[name='description']" : "resizeTextarea"

  keymap: (e) ->
    if e.target.name == 'title'
      switch e.which
        when 38, 40 then @move(e)
        when 13 then @update(e)
    else if e.target.name == 'description'
      switch e.which
        when 38 then @move(e) if Actions.Mixins.CarerPosition.atFirstLine(e.target)
        when 40 then @move(e) if Actions.Mixins.CarerPosition.atLastLine(e.target)

  resizeTextarea: (e) ->
    hCheck = !($.browser.msie || $.browser.opera)
    # event or initialize element?
    e = e.target || e

    # find content length and box width
    vlen = e.value.length
    ewidth = e.offsetWidth

    if vlen != e.valLength || ewidth != e.boxWidth || e.style.height != e.scrollHeight
      if hCheck && (vlen < e.valLength || ewidth != e.boxWidth)
        e.style.height = "0px"

      h = Math.max('54', e.scrollHeight)

      e.style.overflow = "auto"
      e.style.height = h + "px"

      e.valLength = vlen
      e.boxWidth = ewidth

    return true


  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @$("textarea[name='title']").val()
    description = @$("textarea[name='description']").val()
    if @model.get('title') != title || @model.get('description') != description
      @model.save({ title: title, description: description },
        success: (template) => @model = template
      )
    @focus_next() if e.keyCode == 13

  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')
    @$('.description').show()
    @resizeTextarea(@$("textarea[name='description']")[0])

  publish: ->
    $.post "/templates/#{@model.id}/publications.json", (data) ->
      if data._id
        window.location.replace("/publications/#{data._id}")

  render: ->
    $(@el).html(@template({ id: @model.id, title: @model.get('title'), description: @model.get('description') }))
    return this