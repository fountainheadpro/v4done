module TemplateStepsHelpers
  def create_templates(user)
    @templates = []
    ["Apple pie", "Pumpkin Pie", "Cheesecake"].each do |title|
      @templates << user.templates.create(title: title)
    end
  end

  def create_template_with_subitems(user)
    @template = user.templates.create title: 'Apple Pie'
    item = @template.items.create title: 'Ingredients'
    @template.items.create title: '1 recipe pastry for a 9 inch double crust pie', parent_id: item.id
    @template.items.create title: '1/2 cup unsalted butter', parent_id: item.id
    @template.items.create title: '3 tablespoons all-purpose flour', parent_id: item.id
    @template.items.create title: '1/4 cup water', parent_id: item.id
    @template.items.create title: '1/2 cup white sugar', parent_id: item.id
    @template.items.create title: '1/2 cup packed brown sugar', parent_id: item.id
    @template.items.create title: '8 Granny Smith apples - peeled, cored and sliced', parent_id: item.id
    @template.items.create title: 'Directions'
  end

  def visit_template(template)
    visit '/templates'
    click_link template.title
  end

  def visit_item(item)
    if !item.parent_id.nil?
      visit_item(item.parent_item)
    else
      visit_template(item.template)
    end
    page.find(:xpath, "//a[contains(@href, '#{item.id}')]").click
  end
end

World(TemplateStepsHelpers)