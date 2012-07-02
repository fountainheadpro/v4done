Actions.Views.Items ||= {}

class Actions.Views.Items.BaseItemView extends Backbone.View

  title: Actions.Mixins.CommonElements.title
  description: Actions.Mixins.CommonElements.description

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


