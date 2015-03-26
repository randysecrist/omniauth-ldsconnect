require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'

module OmniAuth
  module Strategies
    class Ldsconnect < OmniAuth::Strategies::OAuth2
      class NoAuthorizationCodeError < StandardError; end

      DEFAULT_SCOPE = ''

      option :client_options, {
        site: 'https://lds.io',
        authorize_url: '/api/oauth3/authorize',
        token_url: '/api/oauth3/token',
        profile_url: '/api/oauth3/accounts'
      }

      option :token_params, {
        parse: :query
      }

      option :access_token_options, {
        header_format: 'OAuth %s',
        param_name: 'access_token'
      }

      option :authorize_options, [:scope]

      uid { profile_info['currentUserId'] }

      extra do
        profile_info
      end

      def profile_info
        url = "#{options.client_options[:profile_url]}?access_token=#{access_token.token}"
        @profile_info ||= access_token.get(url).parsed || { }
      end

      def authorize_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      def build_access_token
        ssl_options = options.client_options[:ssl].to_hash.symbolize_keys rescue {}
        token_client = Faraday.new url: options.client_options[:site], ssl: ssl_options
        post_params = {
          grant_type: 'authorization_code',
          code: request.params['code'],
          redirect_uri: self.callback_url,
        }
        auth = "Basic #{Base64.encode64([options.client_id, options.client_secret].join(':')).gsub("\n", '')}"
        resp = token_client.post(options.client_options[:token_url], post_params, 'Authorization'=>auth)
        decoded = MultiJson.decode resp.body
        token = decoded["access_token"]
        self.access_token = ::OAuth2::AccessToken.from_hash client, decoded.merge(access_token_options)
      end

      private
      def access_token_options
        options.access_token_options.inject({ }) do |hash, (key, value)|
          hash[key.to_sym] = value
          hash
        end
      end

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end

    end
  end
end
