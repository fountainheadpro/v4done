Actions.Views.Templates ||= {}

class Actions.Views.Templates.TemplateHeaderEditView extends Backbone.View

  template: JST["apps/maven_tools/templates/templates/edit"]
  className: 'template'
  tagName: 'header'

  focus_next: Actions.Mixins.Navigatable['focus_next']
  focus_prev: Actions.Mixins.Navigatable['focus_prev']

  title: Actions.Mixins.CommonElements.title
  description: Actions.Mixins.CommonElements.description

  events:
    "focusin textarea" : "highlight"
    "focusin div[name='description']" : "highlight"
    "keydown textarea" : "keymap"
    "keydown div[name='description']" : "keymap"
    "blur textarea"    : "update"
    "blur div[name='description']"    : "update"


  keymap: (e) ->
    if e.target.name == 'title'
      switch e.which
        when 38 then @focus_prev()
        when 40 then @focus_next()
        when 13 then @update(e)
    else if e.target.name == 'description'
      switch e.which
        when 38 then @move(e) if Actions.Mixins.CarerPosition.atFirstLine(e.target)
        when 40 then @move(e) if Actions.Mixins.CarerPosition.atLastLine(e.target)


  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title=@title().val()
    description=@description().html()
    if @model.get('title') != title || @model.get('description') != description
      @model.save({ title: title, description: description },
        success: (template) => @model = template
      )
    @focus_next() if e.keyCode == 13

  highlight: ->
    #$('.selected div[name="description"]').each (i, item)->
    #  $(item).parent().hide() if $(item).val() == ''
    #$('.selected').removeClass('selected')
    $('.selected').addClass('selected')
    @$('.description').show()
    #@$('#description').show()

  render: ->
    $(@el).html(@template({ id: @model.id, title: @model.get('title'), description: @model.get('description') }))
    @description().action_editor()
    return this

