describe "Actions.Views.Templates.IndexView", ->
  beforeEach ->
    @templates = new Actions.Collections.TemplatesCollection()
    @view = new Actions.Views.Templates.IndexView(templates: @templates)

  describe "Instantiation", ->
    it "creates a list element", ->
      expect(@view.el.nodeName).toEqual("UL")

    it "have a class of 'unstyled'", ->
      expect($(@view.el)).toHaveClass('unstyled')

  describe "Rendering", ->
    beforeEach ->
      @templateView = new Backbone.View()
      @templateView.render = ->
        @el = document.createElement('li')
        return this
      @templateRenderSpy = sinon.spy(@templateView, "render");
      @templateViewStub = sinon.stub(Actions.Views.Templates, "TemplateView").returns(@templateView)
      @template1 = new Backbone.Model({ id: 1, title: 'foo' })
      @template2 = new Backbone.Model({ id: 2, title: 'bar' })
      @view.options.templates = new Backbone.Collection([@template1, @template2])
      @view.render()

    afterEach ->
      Actions.Views.Templates.TemplateView.restore()

    it "create a Template view for each template item", ->
      expect(@templateViewStub).toHaveBeenCalledTwice()
      expect(@templateViewStub).toHaveBeenCalledWith({ model: @template1 })
      expect(@templateViewStub).toHaveBeenCalledWith({ model: @template2 })

    it "renders each Template view", ->
      expect(@templateRenderSpy).toHaveBeenCalledTwice()

    it "prepends the template to the template list", ->
      expect($(@view.el).children().length).toEqual(2)

    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)
