class ApplicationMailer < ActionMailer::Base
  # form にスペースが入っているとエラーになるので注意
  default from: 'BookSearchService'
  layout 'mailer'
end
