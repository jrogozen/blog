module ValidUserHelper
  def age_token(user, client_id)
    user.tokens[client_id]['updated_at'] = Time.now - (DeviseTokenAuth.batch_request_buffer_throttle + 10.seconds)
    user.save!
  end
end

RSpec.configure do |config|
  config.include ValidUserHelper, :type => :controller
end