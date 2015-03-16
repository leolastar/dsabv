# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/event_registration
  def event_registration
    EventMailer.event_registration
  end

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/event_cancellation
  def event_cancellation
    EventMailer.event_cancellation
  end

end
