class JwtService
  HMAC_SECRET = ENV['JWT_SECRET_KEY']

  def self.encode(payload)
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' })
  end
end
