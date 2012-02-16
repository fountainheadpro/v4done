module UserStepsHelpers
  def valid_user
    @user ||= { name: "Testy McUserton", email: "testy@userton.com", password: "please", password_confirmation: "please"}
  end

  def sign_up(user)
    visit '/users/sign_up'
    fill_in "Name", :with => user[:name]
    fill_in "Email", :with => user[:email]
    fill_in "Password", :with => user[:password]
    fill_in "Password confirmation", :with => user[:password_confirmation]
    click_button "Sign up"
  end

  def sign_in(user)
    visit '/users/sign_in'
    fill_in "Email", :with => user[:email]
    fill_in "Password", :with => user[:password]
    click_button "Sign in"
  end

  def sign_out
    delete '/users/sign_out'
  end

  def current_user
    @current_user ||= User.first(conditions: { email: valid_user[:email] })
  end
end

World(UserStepsHelpers)