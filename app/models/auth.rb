require 'jwt'

class Auth
  ALOGRITHM = 'HS256'

  def self.encrypt(payload)
    JWT.encode(payload, secret_key, ALOGRITHM)
  end

  def self.decode(token)
    JWT.decode(token, secret_key, { algorithm: ALOGRITHM }).first
  end

  def self.secret_key
    Rails.application.credentials.secret_key
  end

end