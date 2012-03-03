module TemplateStepsHelpers
  def visit_template(template)
    visit '/templates'
    click_link template.title
  end

  def visit_item(item)
    if item.root?
      visit_template(item.template)
    else
      visit_item(item.parent)
    end
    page.find(:xpath, "//a[contains(@href, '#{item.id}')]").click
  end
end

World(TemplateStepsHelpers)