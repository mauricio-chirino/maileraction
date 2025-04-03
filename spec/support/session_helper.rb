# spec/support/session_helper.rb
module SessionHelper
  def login(user)
    post "/login", params: { email: user.email, password: "password" }
    follow_redirect! if response.redirect?
  end
end
