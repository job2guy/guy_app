class Notifier < ActionMailer::Base
  def activation_instructions(user)
    subject       "Request for Activation"
    from          "Applicant<job2guy>"
    recipients    "job2guy@gmail.com"
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token),:name=>user.name,:email=>user.email,:mobile=>user.mobile
  end
 
  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "Job2Guy Notifier <noreply@job2guy.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => activate_url(user.id)
  end
  def password_reset_instructions(user)  
   subject       "Password Reset Instructions"  
   from          "Job2Guy Notifier <noreply@job2guy.com> "  
   recipients    user.email  
   sent_on       Time.now  
   body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
 end
 
 def message(r = "", m = "", s = "", f = "", c = nil,image_path=nil)
    begin
      ActionMailer::Base.default_content_type = "text/html"
      fail StandardError, "No Recipient" if r.empty? #and b.empty?
      fail StandardError, "No Message" if m.empty? 
      fail StandardError, "No Subject" if s.empty?
      fail StandardError, "No From" if s.empty?
      from f
      recipients r
      cc c if c and !c.empty?
      subject s
      body m
    rescue Exception => e
    end
  end
  
end
