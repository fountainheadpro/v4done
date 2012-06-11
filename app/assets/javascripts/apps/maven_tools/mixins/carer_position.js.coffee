Actions.Mixins.CarerPosition ||= {}
Actions.Mixins.CarerPosition =

  get: (el) ->
    if el.selectionStart
      return el.selectionStart
    else if document.selection
      el.focus()

      r = document.selection.createRange()
      return 0 if r == null

      re = el.createTextRange()
      rc = re.duplicate()
      re.moveToBookmark(r.getBookmark())
      rc.setEndPoint('EndToStart', re)
      return rc.text.length
    else
      return 0

  atFirstLine: (el) ->
    firstLineLength = $(el).val().split('\n')[0].length
    carerPosition = @get(el)
    lineLength = Math.round(el.scrollWidth / 8.1)
    firstLineLength = lineLength if firstLineLength > lineLength
    carerPosition < firstLineLength

  atLastLine: (el) ->
    lines = $(el).val().split('\n')
    lastLineLength = lines[lines.length - 1].length
    carerPosition = @get(el)
    lineLength = Math.round(el.scrollWidth / 8.1)
    lastLineLength = lastLineLength % lineLength if lastLineLength >lineLength
    carerPosition >= $(el).val().length - lastLineLength