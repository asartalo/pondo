require 'timeout'

email = nil
timeout(5) do
  while !email
    email = ActionMailer::Base.deliveries.last
    sleep 0.5
  end
end
email.to.first
