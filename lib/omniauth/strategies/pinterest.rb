require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Pinterest < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://api.pinterest.com/',
        :authorize_url => 'https://api.pinterest.com/oauth/',
        :token_url => 'https://api.pinterest.com/v1/oauth/token'
      }

      def request_phase
        options[:scope] ||= 'read_public'
        options[:response_type] ||= 'code'
        super
      end

      uid { raw_info['id'] }

      info { raw_info }

      def raw_info
        fields = 'first_name,id,last_name,url,account_type,username,bio,image'
        @raw_info ||= access_token.get("/v1/me/?fields=#{fields}").parsed['data']
      end
    end
  end
end
