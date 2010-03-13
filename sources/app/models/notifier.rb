class Notifier < ActionMailer::Base
  
  default_url_options[:host] = "localhost"
  
  def password_reset_instruction(user)
    subject "Password recovery"
    from "Me"
    recipient user.email
    sent_on Time.now
    body :edit_password_reset_url \
      => edit_password_reset_url(user.perishable_token)
  end

end
