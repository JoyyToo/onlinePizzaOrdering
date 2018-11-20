# frozen_string_literal: true

require 'jwt'

module AuthToken
  def AuthToken.issue_token(payload, exp = 30.seconds.from_now)
    payload[:exp] = exp.to_i
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
