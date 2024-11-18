# frozen_string_literal: true

class SignService < ServiceObject
  required_argument :data

  def call
    key = ENV.fetch("SIGN_KEY")
    digest = OpenSSL::Digest.new("sha256")

    OpenSSL::HMAC.digest(digest, key, @data.to_s).encode(Encoding.find("UTF-8"), invalid: :replace, undef: :replace, replace: "")
  end
end
