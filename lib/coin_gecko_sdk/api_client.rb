require 'httparty'
require 'yaml'

module CoinGeckoSdk
  class ApiClient
    include HTTParty
    include Toolkit::Result

    def initialize
      @config = load_config
    end

    def resources
      @resources ||= Resources.new(self)
    end

    def get(endpoint, params = {}, endpoint_name = nil)
      url = build_url(endpoint)
      cache_config = get_cache_config(endpoint_name)
      
      response = if should_cache?(cache_config)
        cache_key = build_cache_key(cache_config, params)
        Rails.cache.fetch(cache_key, expires_in: cache_config[:duration].minutes) do
          HTTParty.get(url, query: params)
        end
      else
        HTTParty.get(url, query: params)
      end

      handle_response(response)
    end

    private

    def load_config
      YAML.load_file(Rails.root.join('lib', 'coin_gecko_sdk', 'endpoints.yml'))
    end

    def base_url
      @config.dig('coin_gecko_api', 'base_url')
    end

    def build_url(endpoint)
      "#{base_url}#{endpoint}"
    end

    def get_cache_config(endpoint_name)
      return { enabled: false } unless endpoint_name
      
      endpoint_config = @config.dig('coin_gecko_api', 'endpoints', endpoint_name)
      return { enabled: false } unless endpoint_config&.dig('cache')
      
      cache_config = endpoint_config['cache']
      {
        enabled: cache_config['enabled'],
        key: cache_config['key'],
        duration: cache_config['duration']
      }
    end

    def should_cache?(cache_config)
      cache_config[:enabled] && cache_config[:duration] > 0
    end

    def build_cache_key(cache_config, params)
      base_key = cache_config[:key]
      
      param_keys = params.keys.sort.map { |key| "#{key}:#{params[key]}" }
      param_string = param_keys.any? ? "_#{param_keys.join('_')}" : ""
      
      [base_key, param_string].compact.join
    end

    def handle_response(response)
      case response.code
      when 200
        Success(response.parsed_response)
      when 404
        Failure(
          status_code: 404,
          message: "Zasób nie został znaleziony"
        )
      when 429
        Failure(
          status_code: 429,
          message: "Przekroczono limit zapytań"
        )
      else
        Failure(
          status_code: response.code,
          message: "Błąd API: #{response.message}"
        )
      end
    rescue StandardError => e
      Failure(
        status_code: 500,
        message: "Błąd połączenia: #{e.message}"
      )
    end
  end
end
