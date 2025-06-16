class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    @url  = edit_web_password_reset_url(token: @user.password_reset_token)
    mail(to: @user.email_address, subject: I18n.t("reset_password.subject"))
  end
end
