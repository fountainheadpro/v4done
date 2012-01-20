//= require backbone/mixins/movable
Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Backbone.View
  template: JST["backbone/templates/items/edit"]
  className: 'item'

  move: Actions.Mixins.Movable['move']
  focus_next: Actions.Mixins.Movable['focus_next']
  focus_prev: Actions.Mixins.Movable['focus_prev']

  events:
    "keydown textarea": "keymap"
    "blur textarea": "update"
    "focusin textarea": "highlight"

  keymap: (e) ->
    switch e.keyCode
      when 38, 40 then @move(e)
      when 8 then @destroy(e)
      when 13 then @update(e)

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @$("textarea[name='title']").val()
    description = @$("textarea[name='description']").val()
    if @model.get('title') != title || @model.get('description') != description
      @model.save({ title: title, description: description },
        success: (item) => @model = item
      )
    if e.keyCode == 13
      if !$(@el).next('.item').hasClass('new_item')
        parentItem = @options.template.items.byParentId(@model.get('parent_id')) if @model.has('parent_id')
        view = new Actions.Views.Items.NewView(template: @options.template, parentItem: parentItem)
        $(@el).after(view.render().el)
      @focus_next()

  destroy: () ->
    if @$('textarea[name="title"]').val() == '' && @$('textarea[name="description"]').val() == ''
      @model.destroy()
      $(@el).unbind()
      @focus_prev()
      @remove()
      return false

  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')
    @$('.description').show()

  render: ->
    $(this.el).html(@template({ title: @model.get('title'), description: @model.get('description'), _id: @model.get('_id'), template_id: @options.template.get('_id'), subitemsCount: @options.subitemsCount}))
    return this