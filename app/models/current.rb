class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user, :account, :api_key
end
