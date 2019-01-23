require 'jwt'

module AuthToken
  # Encodes and signs JWT Payload with expiration
  def AuthToken.issue_token(payload)
    payload.reverse_merge!(meta)
    JWT.encode(payload, "Rails.application.secrets.secret_key_base")
  end

  # Decodes the JWT with the signed secret
  def AuthToken.decode(token)
    JWT.decode(token, "Rails.application.secrets.secret_key_base", false)
  end

  # Validates the payload hash for expiration and meta claims
  def AuthToken.valid?(payload)
    if expired(payload)
      return false
    else
      return true
    end
  end

  # Default options to be encoded in the token
  def AuthToken.meta
    {
        exp: 24.hours.from_now
    }
  end

  # Validates if the token is expired by exp parameter
  def AuthToken.expired(payload)
    decode(payload)[0]['exp'] < Time.now
  end
end