module Keypress
  def keypress(element, key)
    keypress_script = "var e = jQuery.Event('keypress', { keyCode: #{keycode(key)} }); $('#{element}').trigger(e);"
    page.driver.browser.execute_script(keypress_script)
  end

  def keycode(key)
    { enter: 13 }[key]
  end
end

World(Keypress)