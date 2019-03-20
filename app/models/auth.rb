require 'jwt'

class Auth
  ALGORITHM = 'HS256'

  def self.encrypt(payload)
    JWT.encode(payload, secret_key, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, secret_key, { algorithm: ALGORITHM }).first
  end

  def self.secret_key
    # Rails.application.credentials.secret_key_base
    'jajsfjl44552jafs093'
  end

end