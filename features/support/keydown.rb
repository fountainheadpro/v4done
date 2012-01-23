module Keydown
  def keydown(element, key)
    keypress_script = "var e = jQuery.Event('keydown', { keyCode: #{keycode(key)} }); $('#{element}').trigger(e);"
    page.driver.browser.execute_script(keypress_script)
  end

  def keycode(key)
    { enter: 13 }[key]
  end
end

World(Keydown)