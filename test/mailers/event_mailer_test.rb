require 'test_helper'

class EventMailerTest < ActionMailer::TestCase
  test "event_registration" do
    mail = EventMailer.event_registration
    assert_equal "Event registration", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "event_cancellation" do
    mail = EventMailer.event_cancellation
    assert_equal "Event cancellation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
