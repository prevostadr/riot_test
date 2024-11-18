# frozen_string_literal: true

module CryptographyService
  class Decrypt < CryptographyServiceObject
    required_argument :data, :encoding_type

    def call
      not_implemented(@encoding_type) unless self.public_methods.include?(@encoding_type.to_sym)

      encrypt_or_decrypt(@data, @encoding_type)
    end

    def base64(data)
      eval(Base64.decode64(data))
    rescue Exception
      Base64.decode64(data)
    end
  end
end
