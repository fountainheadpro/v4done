Actions.Views.Items ||= {}

class Actions.Views.Items.EditDetailsView extends Actions.Views.Items.BaseItemView
  template: JST["apps/maven_tools/templates/items/edit_details"]
  className: 'item'

  goToParentItem: Actions.Mixins.GoTo['parentItem']

  events:
    "keydown textarea" : "keymap"
    "blur textarea"    : "update"
    "focusin textarea" : "highlight"

  keymap: (e) ->
    if e.shiftKey
      @update(e) if e.which in [38]
      switch e.which
        when 38 then @goToParentItem(@options.template, @model)
    else if e.target.name == 'title'
      switch e.which
        when 38, 40 then @move(e)
        when 8 then @destroy(e)
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
        success: (item) => @model = item
      )
    if e.keyCode == 13 && !e.shiftKey
      if !$(@el).next('.item').hasClass('new_item')
        view = new Actions.Views.Items.NewView(template: @options.template, parentItem: @model)
        $(@el).next().prepend(view.render().el)
      @focus_next()

  destroy: () ->
      super()
      @goToParentItem(@options.template, @model)
      return false

  highlight: ->
    $('.selected div[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected textarea').removeAttr('style')
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')
    @$('.description').show()

  render: ->
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description'), _id: @model.get('_id'), template_id: @options.template.get('_id')}))
    $(@el).find('div[contenteditable=true]').action_editor()
    return this