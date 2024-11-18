class CryptographyController < ApplicationController
  def encrypt
    json_encrypt = CryptographyService::Encrypt.new(data: cryptography_params, encoding_type: "base64").call

    render json: json_encrypt, status: :ok
  end

  def decrypt
    json_decrypt = CryptographyService::Decrypt.new(data: cryptography_params, encoding_type: "base64").call

    render json: json_decrypt, status: :ok
  end

  def sign
    signature = SignService.new(data: cryptography_params).call

    render json: { signature: signature }, status: :ok
  end

  def verify
    response = VerifyService.new(signature: cryptography_params["signature"], data: cryptography_params["data"]).call

    status = response ? :no_content : :bad_request
    head status
  end

  private

  def cryptography_params
    params[:cryptography]
  end
end
