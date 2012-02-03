module TemplateStepsHelpers
  def create_templates(user)
    @templates = []
    ["Apple pie", "Pumpkin Pie", "Cheesecake"].each do |title|
      @templates << user.templates.create(title: title)
    end
  end

  def visit_template(template)
    visit '/templates'
    click_link template.title
  end

  def visit_item(item)
    visit_template(item.template)
    page.find(:xpath, "//a[contains(@href, '#{item.id}')]").click
  end
end

World(TemplateStepsHelpers)