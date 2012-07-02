Actions.Views.Items ||= {}

class Actions.Views.Items.BaseItemView extends Backbone.View

  title: Actions.Mixins.CommonElements.title
  description: Actions.Mixins.CommonElements.description

  constructor: (options) ->
    super(options)
    @model=options.model

