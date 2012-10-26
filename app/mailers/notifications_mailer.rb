class NotificationsMailer < ActionMailer::Base

  default :from => "noreply@knowledgethief.com"
  default :to => "knowledgethief2012@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "KnowledgeThief #{message.subject}")
  end

end