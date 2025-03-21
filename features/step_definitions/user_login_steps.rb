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


Given("we have a user with no existing credentials") do
  expect(:email_address).not_to eq("user120@example.com")
  expect(:password).not_to eq("1235pass")
  expect(:password_confirmation).not_to eq("1235pass")
end

When("the user visits the sign up page") do
  visit signup_path
end

When("they enter {string} and they enter {string}") do |email, password|
 fill_in "user_email", with: email
 fill_in "user_password", with: password
end

When("they click the sign up button") do
  click_button "sign_up"
end

Then(" the user should be redirected to the home page") do
  expect(current_path).to eq(dashboard_path)
end
