#  Project:
#  Description:
#  Author:
#  License:

# the semi-colon before function invocation is a safety net against concatenated
# scripts and/or other plugins which may not be closed properly.
``
# Note that when compiling with coffeescript, the plugin is wrapped in another
# anonymous function. We do not need to pass in undefined as well, since
# coffeescript uses (void 0) instead.
(($, window) ->
  # window is passed through as local variable rather than global
  # as this (slightly) quickens the resolution process and can be more efficiently
  # minified (especially when both are regularly referenced in your plugin).

  # Create the defaults once
  document = window.document
  pluginName = 'defaultPluginName'
  defaults =
    property: 'value'

  # The actual plugin constructor
  class Plugin
    constructor: (@element, options) ->
      # jQuery has an extend method which merges the contents of two or
      # more objects, storing the result in the first object. The first object
      # is generally empty as we don't want to alter the default options for
      # future instances of the plugin
      @options = $.extend {}, defaults, options

      @_defaults = defaults
      @_name = pluginName

      @init()

    init: ->
      # Place initialization logic here
      # You already have access to the DOM element and the options via the instance,
      # e.g., this.element and this.options

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
)(jQuery, window)
