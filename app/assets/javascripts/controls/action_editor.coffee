#  Project: action editor
#  Description: Simple text editor for action description. Includes link parsing and lookups.
#  Author: Sergey Zelvenskiy
#  License: MIT





(($, window) ->
  # window is passed through as local variable rather than global
  # as this (slightly) quickens the resolution process and can be more efficiently
  # minified (especially when both are regularly referenced in your plugin).

  # Create the defaults once
  pluginName = 'action_editor'
  document = window.document
  defaults =
    property: 'value'

  # The actual plugin constructor
  class Plugin
    constructor: (@el, options) ->
      # jQuery has an extend method which merges the contents of two or
      # more objects, storing the result in the first object. The first object
      # is generally empty as we don't want to alter the default options for
      # future instances of the plugin
      @options = $.extend {}, defaults, options
      @_defaults = defaults
      @_name = pluginName

      @init()

    init: ->
      $(@el).on("paste", format)
      $(@el).on("keyup", handle_key_up)
      #$(@el).bind("paste", @format).pasteEvents()

    handle_key_up = (e) ->
      tp=new TextProcessor()
      tp.re_format(@)

    format= (e)->
      pp=new PasteParser()
      pp.handlepaste(@,e)
      #for node in @childNodes
      #  do (node)->
      #    pp.format(node) #if node && node.nodeType==3



  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
)(jQuery, window)