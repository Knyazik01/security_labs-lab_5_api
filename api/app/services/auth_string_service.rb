class AuthStringService
  KEY_ENV = ENV['AUTH_ENCRYPT_SECRET_KEY']
  IV_ENV = ENV['AUTH_ENCRYPT_SECRET_IV']
  ENCRYPTION_ALGORITHM = ENV['AUTH_ENCRYPTION_ALGORITHM']

  KEY_BYTES = Base64.decode64(KEY_ENV)
  IV_BYTES = Base64.decode64(IV_ENV)

  def self.encrypt(data_to_encrypt)
    cipher = OpenSSL::Cipher.new(ENCRYPTION_ALGORITHM)
    cipher.encrypt
    cipher.key = KEY_BYTES
    cipher.iv = IV_BYTES
    # encrypt text
    encrypted = cipher.update(data_to_encrypt) + cipher.final
    # encode to (show in) base 64
    Base64.strict_encode64(encrypted)
  end

  def self.decrypt(encrypted_data_b64)
    # decode from base 64 to bytes
    encrypted_bytes = Base64.decode64(encrypted_data_b64)

    decipher = OpenSSL::Cipher.new(ENCRYPTION_ALGORITHM)
    decipher.decrypt
    decipher.key = KEY_BYTES
    decipher.iv = IV_BYTES
    decrypted = decipher.update(encrypted_bytes) + decipher.final
    decrypted.force_encoding('UTF-8')
  end
end
