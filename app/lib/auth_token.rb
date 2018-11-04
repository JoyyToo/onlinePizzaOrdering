# frozen_string_literal: true

require 'jwt'

module AuthToken
  def AuthToken.issue_token(payload)
    payload['exp'] = 24.hours.from_now.to_i
    JWT.encode(payload, "ewihufiuweghfuiew")
  end

  def AuthToken.decode(token)
    JWT.decode(token, "ewihufiuweghfuiew", false)
  end

  def AuthToken.valid?(token)
    begin
      JWT.decode(token, "ewihufiuweghfuiew", false)
    rescue
      false
    end
  end
end
