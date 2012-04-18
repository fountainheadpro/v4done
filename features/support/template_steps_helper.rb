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

  def create_item(title, opts = {})
    keydown("section#items > .item:eq(#{opts[:after].to_i - 1}) textarea:first", :enter) if opts.try(:[], :after).to_i > 0
    find('#items .new_item').fill_in('title', with: title)
    keydown("#items .new_item:first textarea:first", :enter)
  end
end

World(TemplateStepsHelpers)