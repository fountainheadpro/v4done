describe "Item collection", ->
  describe "filtered byParentId", ->
    beforeEach ->
      @item1 = new Actions.Models.Item({ _id: 1, title: 'foo'})
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


describe "An Item", ->
  beforeEach ->
    @item = new Actions.Models.Item({ _id: 1, title: 'foo'})

  it "should be a root", ->
    expect(@item.isRoot()).toBeTruthy()

  describe "when adding a child", ->
    beforeEach ->
      @child = new Actions.Models.Item({ _id: 2, title: 'bar', parent_id: @item.id})

    describe "the child", ->
      it "should not be the root", ->
        expect(@child.isRoot()).toBeFalsy()

