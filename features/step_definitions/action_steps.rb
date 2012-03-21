### GIVEN ###
Given /^I have project with few actions and subactions$/ do
  @project = Factory.create(:project_with_actions)
end

### WHEN ###
When /^I open this project$/ do
  visit project_actions_url(@project)
end

When /^I open a composite action from this project$/ do
  @action = @project.actions.roots.first
  visit project_action_actions_url(@project, @action)
end

### THEN ###
Then /^I should see the goal on the header$/ do
  page.should have_content(@project.title)
end

Then /^I should see the list of actions, each with status and link to subactions$/ do
  within('#actions') do
    @project.actions.roots.each do |action|
      page.should have_content(action.title)
      within('.action', text: action.title) do
        page.should have_content(action.description)
        page.should have_unchecked_field("action[#{action.id}]")
        page.should have_css("a[href='#{project_action_actions_path(@project, action)}']")
      end
    end
  end
end

Then /^I should see the action title on the header$/ do
  page.should have_content(@action.title)
end

Then /^I should see the action description on top of the screen$/ do
  page.should have_content(@action.description)
end

Then /^I should see the list of subactions, each with status and link to subactions$/ do
  within('#actions') do
    @action.children.each do |subaction|
      page.should have_content(subaction.title)
      within('.action', text: subaction.title) do
        page.should have_content(subaction.description)
        page.should have_unchecked_field("action[#{subaction.id}]")
        page.should have_css("a[href='#{project_action_actions_path(@project, subaction)}']")
      end
    end
  end
end