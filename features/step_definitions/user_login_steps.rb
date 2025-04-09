Given("a user exists with a username {string}, email {string}, and password {string}") do |username, email, password|
  @user = User.create!(username: username, email_address: email, password: password, password_confirmation: password)
end

When("the user visits the login page") do
  visit new_session_path
end

When("the user enters {string} in the username field") do |username|
  fill_in "username", with: username
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
  expect(current_path).to eq(root_path)
end
