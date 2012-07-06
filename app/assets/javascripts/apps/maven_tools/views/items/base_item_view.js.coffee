Actions.Views.Items ||= {}

class Actions.Views.Items.BaseItemView extends Backbone.View

  title: Actions.Mixins.CommonElements.title
  description: Actions.Mixins.CommonElements.description

  base_events:
    "blur .editable"   : "save"
    "focusin .editable": "highlight"
    "jump_down [name=description]" : "next"
    "jump_up [name=description]" : "jump_up"
    "keydown .editable": "keymap"

  keymap: (e) ->
    if e.target.name == 'title'
      switch e.which
        when 38 then @prev()
        when 40 then @next()
        when 8 then @destroy(e)
        when 13 then @save(e)


  constructor: (options) ->
    super(options)
    @model=options.model

  fold: (e) ->
    @description().parent().hide()
    @$el.removeClass('selected')
    @$el.removeAttr('style')

  highlight: (e)->
    @description().parent().show()
    @$el.addClass('selected')
    @container.$el.trigger({type:"item_enter",id: @model?.id})

  inFocus:(e)->
    $(document.activeElement).is(@description()) ||
    $(document.activeElement).is(@title())

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @title().val()
    description = @description().html()
    if @model.get('title') != title || @model.get('description') != description
      @model.save({ title: title, description: description},
        success: (item) => @model = item
      )

  next: (e)->
    @container.$el.trigger({type: "next_item", id: @$el.data('id'), previous_id: @$el.data('previous_id'), origin: @})

  prev: (e)->
    @container.$el.trigger({type: "prev_item", id: @$el.data('id'), previous_id: @$el.data('previous_id'), origin: @})

  jump_up: ()->
    @title().focus()

  expand_description: (e)->
    e.preventDefault()
    e.stopPropagation()
    @description().parent().show()
    @description().focus()
