Actions.Mixins.CommonElements ||= {}

Actions.Mixins.CommonElements =

  title: ->
    @$el.find('[name=title]')

  description: ->
    @$el.find('[name=description]')
