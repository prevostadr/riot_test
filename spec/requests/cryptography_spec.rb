# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Cryptography", type: :request do
  describe "GET /encrypt" do
    it "success" do
      post "/encrypt", params: { "cryptography": { "foo": "foobar", "bar": { "isBar": true } } }
      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.empty?).to be_falsey
      expect(json_response['foo']).to eq('ImZvb2JhciI=')
      expect(json_response['bar']).to eq('eyJpc0JhciI6InRydWUifQ==')
    end
  end

  describe "GET /decrypt" do
    it "success" do
      post "/decrypt", params: { "cryptography": { "foo": "ImZvb2JhciI=", "bar": "eyJpc0JhciI6InRydWUifQ==" } }
      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.empty?).to be_falsey
      expect(json_response['foo']).to eq('foobar')
      expect(json_response['bar']['isBar']).to be_truthy
    end
  end

  describe "GET /sign" do
    it "success" do
      post "/sign", params: { "cryptography": { "foo": "foobar" } }
      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.empty?).to be_falsey
      expect(json_response['signature']).to eq("u(Ls_qun\u001FV!nN^hv\u00167\u001E")
    end
  end

  describe "GET /verify" do
    it "no_content, correct signature" do
      post "/verify", params: { "cryptography": { "signature": "u(Ls_qun\u001FV!nN^hv\u00167\u001E", data: { "foo": "foobar" } } }

      expect(response).to have_http_status(:no_content)
    end

    it "bad_request, wrong signature" do
      post "/verify", params: { "cryptography": { "signature": "u(Ls_qun\u001FV!nN^hv\u00167\u001E", data: { "foo": "foo" } } }

      expect(response).to have_http_status(:bad_request)
    end
  end
end
