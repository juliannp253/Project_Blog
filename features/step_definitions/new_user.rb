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

Then("the user should be redirected to the home page") do
  expect(current_path).to eq(dashboard_show_path)
end
