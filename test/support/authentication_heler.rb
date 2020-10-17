module AuthenticationHelper

  def sign_in(user)
    visit root_path
    click_link('Sign In', match: :first)

    within('form#new_user') do
      fill_in("user_email", with: user.email)
      fill_in("user_password", with: "testing")
    end
    click_button "Log in"
  end
end
