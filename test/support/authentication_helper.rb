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
end
