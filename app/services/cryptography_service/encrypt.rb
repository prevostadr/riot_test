# frozen_string_literal: true

module CryptographyService
  class Encrypt < CryptographyServiceObject
    required_argument :data, :encoding_type

    def call
      not_implemented(@encoding_type) unless self.public_methods.include?(@encoding_type.to_sym)

      encrypt_or_decrypt(@data, @encoding_type)
    end

    def base64(data)
      Base64.strict_encode64(data.to_json)
    end
  end
end
