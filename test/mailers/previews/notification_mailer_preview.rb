# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer/notify_result_update
  def notify_result_update
    NotificationMailer.notify_result_update(dummy_user, "key", 1, 2)
  end

  def dummy_user
    return User.new(
      username: "test",
      email: "test@test.com"
    )
  end
end
