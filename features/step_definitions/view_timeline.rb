Given("there are two users with posts, Bob and Mary") do
  @bob = User.create(email_address: "bob@example.com", password: "1234", password_confirmation: "1234")
  @mary = User.create(email_address: "mary@example.com", password: "5678", password_confirmation: "5678")
 expect(@bob.email_address).to eq("bob@example.com")
 expect(@bob.password).to eq("1234")
 expect(@bob.password_confirmation).to eq("1234")
 expect(@mary.email_address).to eq("mary@example.com")
 expect(@mary.password).to eq("5678")
 expect(@mary.password_confirmation).to eq("5678")
end

When("I sign in as Bob") do
  visit new_session_path
  fill_in "user_email", with: "bob@example.com"
  fill_in "user_password", with: "1234"
  cick_button "Login"
end

When("I visit the homepage") do
  expect(current_path).to eq(dashboard_show_path)
end

Then("I should see the everyone's posts") do
  expect(:is_posts).to eq(True)
end

# When("everyone's posts should be in reverse order") do
# end
