module TemplateStepsHelpers
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