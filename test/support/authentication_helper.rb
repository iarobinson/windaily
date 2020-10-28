module AuthenticationHelper

  def sign_in(user)
    visit new_user_session_path
    password = user.password || "testing"
    within('form') do
      fill_in("user_email", with: user.email)
      fill_in("user_password", with: password)
    end
    click_button "Log in"
  end

  def create_new_user
    visit new_user_registration_path
    within("form") do
      fill_in "user_email", with: "test_user@testing.com"
      fill_in "user_password", with: "testing"
      fill_in "user_password_confirmation", with: "testing"
      click_on "Sign up"
    end
  end
end
