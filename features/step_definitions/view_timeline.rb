Given("there are two users with posts, Bob and Mary") do
 expect(:email_address).to eq("bob@example.com")
 expect(:password).to eq("1234")
 expect(:password_confirmation).to eq("1234")
 expect(:email_address).to eq("mary@example.com")
 expect(:password).to eq("5678")
 expect(:password_confirmation).to eq("5678")
end

When("I sign in as Bob") do
  visit new_session_path
  fill_in "user_email", with: "bob@example.com"
  fill_in "user_password", with: "1234"
  cick_button "Login"
end

When("I visit the homepage") do
  visit dashboard_path
end

Then("I should see the everyone's posts") do
  expect(:is_posts).to eq(True)
end

# When("everyone's posts should be in reverse order") do
# end
