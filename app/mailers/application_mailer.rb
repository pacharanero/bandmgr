class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM_ADDRESS", "no-reply@bandmgr.test")
  layout "mailer"
end
