Given("a user exists with email {string} and password {string}") do |email, password|
  @user = User.create!(email_address: email, password: password, password_confirmation: password)
end

When("the user visits the login page") do
  visit new_session_path
end

When("the user enters {string} in the email field") do |email|
  fill_in "user_email", with: email
end

When("the user enters {string} in the password field") do |password|
  fill_in "user_password", with: password
end

When("the user clicks the login button") do
  click_button "Login"
end

Then("the user should be redirected to the dashboard") do
  expect(current_path).to eq(dashboard_path)
end
