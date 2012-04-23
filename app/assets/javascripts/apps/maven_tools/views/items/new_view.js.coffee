Actions.Views.Items||= {}

class Actions.Views.Items.NewView extends Backbone.View
  template: JST["apps/maven_tools/templates/items/new"]
  className: 'item new_item'

  move: Actions.Mixins.Movable['move']
  focus_next: Actions.Mixins.Movable['focus_next']
  focus_prev: Actions.Mixins.Movable['focus_prev']
  goToParentItem: Actions.Mixins.GoTo['parentItem']
  goToItemDetails: Actions.Mixins.GoTo['itemDetails']


  events:
    "keydown textarea": "keymap"
    "focusin textarea": "highlight"
    "click i.destroy" : "destroy"

  constructor: (options) ->
    super(options)

  keymap: (e) ->
    if e.shiftKey
      switch e.which
        when 38 then @goToParentItem(@options.template, @options.parentItem)
        when 13,40 then @save(e, true)
    else
      switch e.keyCode
        when 38, 40 then @move(e)
        when 8 then @destroy(e)
        when 13 then @save(e, false)

  save: (e,details) ->
    e.preventDefault()
    e.stopPropagation()

    title = @$("textarea[name='title']").val()
    description = @$("textarea[name='description']").val()
    parentId = @options.parentItem.get('_id') if @options.parentItem?
    previousId = $(@el).prevAll('.item.edit_item:first').data('id')
    @options.template.items.create({ title: title, description: description, parent_id: parentId, previous_id: previousId },
      success: (item) =>
        if details
          @goToItemDetails(@options.template, item)
        else
          @$('textarea[name="title"]').val('')
          @$('textarea[name="description"]').val('')
          view = new Actions.Views.Items.EditView({ model: item, template: @options.template})
          $(@el).before(view.render().el)
          if e.keyCode != 13
            @destroy(e)
          else
            @$('textarea[name="title"]').focus()
    )

  destroy: (e) ->
    if (@$('textarea[name="title"]').val() == '' && @$('textarea[name="description"]').val() == '') || (e.which != 8 && confirm("Are you sure?"))
      $(@el).unbind()
      @focus_prev() if e.keyCode == 8
      @remove()
      return false

  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')
    @$('.description').show()

  render: ->
    $(@el).html(@template())

    return this