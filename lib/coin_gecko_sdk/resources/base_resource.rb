module CoinGeckoSdk
  module Resources
    class BaseResource
      extend Toolkit::Result

      private

      def self.api_client
        @api_client ||= ApiClient.new
      end

      def self.endpoint_config(endpoint_name)
        config.dig('coin_gecko_api', 'endpoints', endpoint_name)
      end

      def self.endpoint_path(endpoint_name)
        endpoint_config(endpoint_name).dig("path")
      end

      def self.config
        @config ||= YAML.load_file(Rails.root.join('lib', 'coin_gecko_sdk', 'endpoints.yml'))
      end

      def self.call_endpoint(endpoint_name, params = {}, url_params = {})
        path = endpoint_path(endpoint_name)

        url_params.each { |key, value| path = path.gsub("{#{key}}", value.to_s) }
        api_client.get(path, params, endpoint_name)
      end
    end
  end
end
