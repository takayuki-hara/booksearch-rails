class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.notify_result_update.subject
  #
  def notify_result_update(user, keyword, before_count, after_count)
    @user = user
    @keyword = keyword
    @before_count = before_count
    @after_count = after_count

    mail to: user.email,
         subject: '検索結果が更新されました'
  end
end
