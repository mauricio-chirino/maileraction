# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    @url  = edit_web_password_reset_url(token: @user.password_reset_token)
    mail(to: @user.email_address, subject: "Restablece tu contraseña")
  end
end
