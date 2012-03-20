### GIVEN ###
Given /^I have project with few actions and subactions$/ do
  @project = Factory.create(:project_with_actions)
end

### WHEN ###
When /^I open this project$/ do
  visit project_actions_url(@project)
end

### THEN ###
Then /^I should see the title of project on the header$/ do
  page.should have_content(@project.title)
end

Then /^I should see the list of actions, each with status and link to subactions$/ do
  within('#actions') do
    @project.actions.roots.each do |action|
      page.should have_content(action.title)
      page.should have_content(action.description)
    end
  end
end