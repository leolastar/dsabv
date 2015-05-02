class EventMailer < ActionMailer::Base
  default from: "noreply@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.event_registration.subject
  #
  def event_registration(user, time_slot)
    @user = user
    @time_slot = time_slot
    mail to: user.email, subject: "Event Registration"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.event_cancellation.subject
  #
  def event_cancellation(user, time_slot)
    @user = user
    @time_slot = time_slot
    mail to: user.email, subject: "Event Cancellation"
  end
end
