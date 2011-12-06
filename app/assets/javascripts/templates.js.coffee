Template =
  remove_fields: (link) ->
    $(link).prev("input[type=hidden]").val("1")
    $(link).closest(".fields").hide()
  remove_new_fields: (link) ->
    $(link).closest('.item').remove()
  highlight_fields: (field) ->
    $('div[class="item selected"]').removeClass('selected')
    $(field).closest('.item').addClass('selected')
  add_fields: (link) ->
    level = $(link).closest('.item').attr('level')
    if level > 1
      prev_item = $(link).closest('.item').prevAll("div[level='#{ level }']").first()
      path = prev_item.find('input:text').attr('id').match(/\d+/g)[0..-2]
    else
      path = []
    path.push(new Date().getTime())
    new_item = "<div class='item' level='#{ level }'><div class='fields' style='#{ @fields_style(level) }'>
                    <input id='#{ @new_id(path) }' name='#{ @new_name(path) }' size='30' style='#{ @input_style(level) }' type='text' placeholder='Add item'>
                    <a href='' class='remove_new_fields'>[remove]</a>
                    <a href='' class='add_child_fields'>[add child]</a>
                </div>"
    $(link).closest('.item').before(new_item)
  add_child_fields: (link) ->
    prev_item = $(link).closest('.item')
    level = parseInt(prev_item.attr("level")) + 1
    path = prev_item.find('input:text').attr('id').match(/\d+/g)
    path.push(new Date().getTime())
    new_item = "<div class='item' level='#{ level }'>
                  <div class='fields' style='#{ @fields_style(level) }'>
                    <input id='#{ @new_id(path) }' name='#{ @new_name(path) }' size='30' style='#{ @input_style(level) }' type='text' placeholder='Add item'>
                    <a href='' class='remove_new_fields'>[remove]</a>
                    <a href='' class='add_child_fields'>[add child]</a>
                  </div>
                </div>
                <div class='item' level='#{ level }'>
                  <div class='fields' style='#{ @fields_style(level) }'>
                    <a href='' class='add_fields'>[new item]</a>
                  </div>
                </div>"
    prev_item.after(new_item)
    $(link).remove()
  fields_style: (level) -> "width: #{ (760 - (level * 15)) }px; margin-left: #{ (level * 15) }px;"
  input_style: (level) -> "width: #{ (610 - (level * 15)) }px;"
  new_id: (path) -> "template_items_attributes_#{ path.join('_items_attributes_') }_title"
  new_name: (path) -> "template[items_attributes][#{ path.join('][items_attributes][') }][title]"
    


jQuery ->
  $('a[class="remove_fields"]').live 'click', () ->
    Template.remove_fields(this)
    false
  $('a[class="remove_new_fields"]').live 'click', () ->
    Template.remove_new_fields(this)
    false
  $('input:text').live 'focus', () ->
    Template.highlight_fields(this)
    false
  $('a[class="add_fields"]').live 'click', () ->
    Template.add_fields(this)
    false
  $('a[class="add_child_fields"]').live 'click', () ->
    Template.add_child_fields(this)
    false
