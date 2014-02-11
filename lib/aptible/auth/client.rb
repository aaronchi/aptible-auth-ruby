require 'hyperresource'

module Aptible
  module Auth
    class Client < HyperResource
      attr_accessor :token, :config

      def initialize(options = {})
        unless options.is_a?(Hash)
          fail ArgumentError, 'Call Aptible::Auth::Client.new with a Hash'
        end
        self.token = options[:token]

        options[:root] ||= config.root_url
        options[:headers] ||= { 'Content-Type' => 'application/json' }
        options[:headers].merge!(
          'Authorization' => "Bearer #{bearer_token}"
        ) if options[:token]

        super(options)
      end

      def bearer_token
        # REVIEW: Should we really allow any token type here?
        case token
        when Aptible::Auth::Token then token.access_token
        when Fridge::AccessToken then token.to_s
        when String then token
        end
      end

      def config
        @config ||= Aptible::Auth.configuration
      end
    end
  end
end
