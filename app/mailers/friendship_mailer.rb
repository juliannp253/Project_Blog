class FriendshipMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  def friend_request_email(sender, receiver)
    @sender = sender
    @receiver = receiver
    mail(to: @receiver.email_address, subject: "#{@sender.email_address} sent you a friend request")
  end
end
