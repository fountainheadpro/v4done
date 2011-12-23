describe "Actions.Views.Breadcrumbs.BreadcrumbView", ->
  beforeEach ->
    @view = new Actions.Views.Breadcrumbs.BreadcrumbView(title: 'Templates', link: '#/index', active: false)

  describe "Instantiation", ->
    it "creates a list item element", ->
      expect(@view.el.nodeName).toEqual("LI")

  describe "Rendering", ->
    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)

    describe "Template", ->
      beforeEach ->
        $(".page-header ul.breadcrumbs").prepend(@view.render().el)

      it "has the correct title text", ->
        expect($(@view.el).find('li > a')).toHaveAttr('href', '#/index')

      it "has the correct URL", ->
        expect($(@view.el).find('li > a')).toHaveText('Templates')