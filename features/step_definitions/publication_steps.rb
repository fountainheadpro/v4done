### WHEN ###
When /^I look at some publication$/ do
  @publication = FactoryGirl.create(:publication)
  visit publication_path(@publication)
end

### THEN ###
Then /^I should see nested actions of this publication$/ do
  page.should have_content(@publication.template.title)
  within("ul.items") do
    @publication.template.items.roots.each do |item|
      page.should have_content(item.title)
      within("li", text: item.title) do
        item.children.each do |item|
          page.should have_content(item.title)
        end
      end
    end
  end
end