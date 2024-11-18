# frozen_string_literal: true

class CryptographyServiceObject < ServiceObject
  def not_implemented(encoding_type)
    raise NotImplementedError, "Encoding type #{encoding_type} not implemented"
  end

  def encrypt_or_decrypt(data, encoding_type)
    encrypted_object = {}

    data.each do |key, value|
      encrypted_object[key] = self.send(encoding_type, value)
    end
    encrypted_object
  end
end
