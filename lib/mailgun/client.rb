require 'rest_client'


module Mailgun
  class Client
    attr_reader :api_key, :domain

    def initialize(api_key, domain)
      @api_key = api_key
      @domain = domain
    end

    def send_message(options)
      RestClient.post mailgun_url, options
    end

    def mailgun_url
      api_url+"/messages"
    end

    def api_url
      "https://api:#{api_key}@api.mailgun.net/v3/#{domain}"
    end

    def base_url
      "https://api:#{api_key}@api.mailgun.net/v3"
    end

    def get_domains(params = {})
      RestClient.get api_url+'/domains', params
    end

  end
end
