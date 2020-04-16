# lib/json_web_token.rb

#TODO: change api_audience in the credentials before deploying

# frozen_string_literal: true
require 'net/http'
require 'uri'

class JsonWebToken
  def self.verify(token)
    JWT.decode(token, nil,
               true, # Verify the signature of this token
               algorithm: 'RS256',
               iss: 'https://maintenance-chain.auth0.com/',
               verify_iss: true,
               aud: Rails.application.secrets.auth0_api_audience,
               verify_aud: true) do |header|
      jwks_hash[header['kid']]
    end
  end

  def self.getUser(token)
    public_key = get_public_key
    decoded = JWT.decode(
      token, 
      public_key,
      true,
      algorithm: 'RS256'
    )
    decoded[0]['sub']
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI("https://maintenance-chain.auth0.com/.well-known/jwks.json")
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    Hash[
      jwks_keys
      .map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k['x5c'].first)
          ).public_key
        ]
      end
    ]
  end

  # TODO: This isn't very DRY, it does the same thing as jwks_hash but just returns the public key instead of the hash with a key of 'kid' and its value is the public key
  def self.get_public_key
    jwks_raw = Net::HTTP.get URI("https://maintenance-chain.auth0.com/.well-known/jwks.json")
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    hash = Hash[
      jwks_keys
      .map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k['x5c'].first)
          ).public_key
        ]
      end
    ]
    hash.values[0]
  end
end
