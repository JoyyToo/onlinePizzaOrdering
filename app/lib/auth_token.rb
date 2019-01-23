# frozen_string_literal: true

require 'jwt'

module AuthToken
  def AuthToken.issue_token(payload, expiration = 30.seconds.from_now)
    payload[:exp] = expiration
    JWT.encode(payload, "ewihufiuweghfuiew")
  end

  def AuthToken.decode(token)
    JWT.decode(token, "ewihufiuweghfuiew", false)
  end

  def AuthToken.valid?(token)
    begin
      JWT.decode(token, "ewihufiuweghfuiew", false)
    rescue
      'FAILED'
    end
  end
end
