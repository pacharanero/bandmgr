module AuthenticationHelpers
  def sign_in_as(user, password: "password")
    post session_path, params: { session: { email_address: user.email_address, password: password } }
  end
end
