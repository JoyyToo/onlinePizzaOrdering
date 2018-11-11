class Message
  def self.not_found
    'Sorry, record was not found.'
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.no_email
    'Please add valid email'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'You are not Authorized here'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.feedback_submitted
    'Your feedback has been submitted'
  end

  def self.deleted
    'Successfully deleted'
  end

  def self.updated
    'Successfully updated'
  end

  def self.new_admin
    'User is now an admin'
  end

  def self.no_data
    'Sorry, there is no data here'
  end
end
