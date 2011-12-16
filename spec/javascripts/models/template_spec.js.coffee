describe "Template model", ->
  describe "when instantiated", ->
    it "should exhibit attributes", ->
      t = new Actions.Models.Template({ title: 'Banana Pie'})
      expect(t.get('title')).toEqual('Banana Pie')