describe "Item collection", ->
  describe "filtered byParentId", ->
    beforeEach ->
      @item1 = new Actions.Models.Item({ _id: 1, title: 'foo', parent_id: null})
      @item2 = new Actions.Models.Item({ _id: 2, title: 'bar', parent_id: 1})
      @item3 = new Actions.Models.Item({ _id: 3, title: 'baz', parent_id: 1})
      @item4 = new Actions.Models.Item({ _id: 4, title: 'qux', parent_id: 3})

    it "returns only items with specific parent_id", ->
      items = new Actions.Collections.ItemsCollection([@item1, @item2, @item3, @item4])
      expect(items.byParentId(null).length).toEqual(1)
      expect(items.byParentId(null).at(0)).toEqual(@item1)
      expect(items.byParentId(1).length).toEqual(2)
      expect(items.byParentId(1).at(0)).toEqual(@item2)
      expect(items.byParentId(1).at(1)).toEqual(@item3)
      expect(items.byParentId(3).length).toEqual(1)
      expect(items.byParentId(3).at(0)).toEqual(@item4)
      expect(items.byParentId(4).length).toEqual(0)
