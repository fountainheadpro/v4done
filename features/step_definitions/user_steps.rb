### GIVEN ###
Given /^I am not logged in$/ do
  sign_out
end

Given /^I am logged in$/ do
  @current_user = FactoryGirl.create(:user, valid_user)
  sign_in valid_user
end

Given /^I exist as a user$/ do
  @current_user = FactoryGirl.create(:user, valid_user)
end

Given /^I do not exist as a user$/ do
  User.find(:first, :conditions => { :email => valid_user[:email] }).should be_nil
  sign_out
end

### WHEN ###
When /^I sign out$/ do
  click_link "Logout"
end

When /^I sign up with valid user data$/ do
  sign_up valid_user
end

When /^I sign up with an invalid email$/ do
  user = valid_user.merge(:email => "notanemail")
  sign_up user
end

When /^I sign up without a confirmed password$/ do
  user = valid_user.merge(:password_confirmation => "")
  sign_up user
end

When /^I sign up without a password$/ do
  user = valid_user.merge(:password => "")
  sign_up user
end

When /^I sign up with a mismatched password confirmation$/ do
  user = valid_user.merge(:password_confirmation => "please123")
  sign_up user
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong password$/ do
  user = valid_user.merge(:password => "wrongpass")
  sign_in user
end

When /^I sign in with valid credintials$/ do
  sign_in valid_user
end

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "Name", :with => "newname"
  fill_in "Current password", :with => valid_user[:password]
  click_button "Update"
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Sign in"
  page.should_not have_content "Logout"
end

Then /^I should see a succesfull sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "You need to sign in or sign up before continuing"
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I see my name on page$/ do
  page.should have_content current_user.name
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end
