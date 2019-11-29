require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "confirm_user" do
    mail = AdminMailer.confirm_user
    assert_equal "Confirm user", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
