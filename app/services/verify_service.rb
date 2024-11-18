# frozen_string_literal: true

class VerifyService < ServiceObject
  required_argument :signature, :data

  def call
    signed_data = SignService.new(data: @data).call

    signed_data === @signature
  end
end
