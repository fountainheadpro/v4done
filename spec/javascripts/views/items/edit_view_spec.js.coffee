describe "Actions.Views.Items.EditView", ->
  beforeEach ->
    @model = new Backbone.Model({ _id: 1, title: 'foo' })
    @view = new Actions.Views.Items.EditView(model: @model)

  describe "Instantiation", ->
    it "creates a list item element", ->
      expect(@view.el.nodeName).toEqual("DIV")

    it "have a class of 'item'", ->
      expect($(@view.el)).toHaveClass('item')

  describe "Rendering", ->
    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)

    describe "Template", ->
      beforeEach ->
        $("#templates").html(@view.render().el)

      it "has the correct title text", ->
        expect($(@view.el).find('.title')).toHaveText('foo')
