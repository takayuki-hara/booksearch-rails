require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "notify_result_update" do
    mail = NotificationMailer.notify_result_update
    assert_equal "Notify result update", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
