module AuthenticationHelper

  def sign_in(user)
    binding.pry
    visit new_session_path
  end
end
