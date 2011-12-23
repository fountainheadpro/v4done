describe "Actions.Views.Templates.TemplateView", ->
  beforeEach ->
    @model = new Backbone.Model({ _id: 1, title: 'foo' })
    @view = new Actions.Views.Templates.TemplateView(model: @model)

  describe "Instantiation", ->
    it "creates a list item element", ->
      expect(@view.el.nodeName).toEqual("LI")

  describe "Rendering", ->
    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)

    describe "Template", ->
      beforeEach ->
        $("#templates ul").prepend(@view.render().el)

      it "has the correct URL", ->
        expect($(@view.el).find('h2 > a')).toHaveAttr('href', '#/1/items')

      it "has the correct title text", ->
        expect($(@view.el).find('h2 > a')).toHaveText('foo')