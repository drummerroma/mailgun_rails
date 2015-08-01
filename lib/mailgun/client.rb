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

   ########## API Calls #########

    # not yet tested
    def validate_address(value)
      RestClient.get base_url + "/address/validate", address: value
    end

    def parse_addresses(values)
      RestClient.get base_url + "/address/parse", addresses: Array(values).join(',')
    end

    def get_message(key)
      RestClient.get api_url + "/messages/#{key}"
    end

    def get_mime_message(key)
      RestClient.get api_url + "/messages/#{key}, {}, {'Accept' => 'message/rfc2822'}"
    end

    def delete_message(key)
      RestClient.delete api_url + "/messages/#{key}"
    end


    # domains
    #https://documentation.mailgun.com/api-domains.html
    def get_domains(params = {})
      RestClient.get base_url+'/domains', params
    end

    def get_domain(name)
      RestClient.get base_url+"/domains/#{name}"
    end

    def add_domain(attributes = {})
      RestClient.post base_url+"/domains", attributes
    end

    def delete_domain(name)
      RestClient.delete base_url+"/domains/#{name}"
    end


    # lists
    # https://documentation.mailgun.com/api-mailinglists.html
    def get_lists(params = {})
      RestClient.get base_url+'/lists', params
    end

    def get_list(address)
      RestClient.get base_url+"/lists/#{address}"
    end

    # MAILGUN.add_list({address: "cinema@#{domain}", description: 'Cinema'})
    def add_list(attributes = {})
      RestClient.post base_url+"/lists", attributes
    end

    def update_list(address, attributes = {})
      RestClient.put base_url+"/lists/#{address}", attributes
    end

    def delete_list(address)
      RestClient.delete base_url+"/lists/#{address}"
    end

    def get_list_members(list_address, params = {})
      RestClient.get base_url+"/lists/#{list_address}/members", params
    end

    def get_list_member(list_address, member_address)
      RestClient.get base_url+"/lists/#{list_address}/members/#{member_address}"
    end

    def add_list_member(list_address, member_attributes)
      RestClient.post base_url+"/lists/#{list_address}/members", member_attributes
    end

    def update_list_member(list_address, member_address, member_attributes)
      RestClient.put base_url+"/lists/#{list_address}/members/#{member_address}", member_attributes
    end

    def delete_list_member(list_address, member_address)
      RestClient.delete base_url+"/lists/#{list_address}/members/#{member_address}"
    end

    def get_list_stats(list_address)
      RestClient.get base_url+"/lists/#{list_address}/stats"
    end

    # campaign
    # https://documentation.mailgun.com/api-campaigns.html#campaigns
    def get_campaigns(params = {})
      RestClient.get api_url+"/campaigns", params
    end

    def get_campaign(id)
      RestClient.get api_url+"/campaigns/#{id}"
    end

    def add_campaign(attributes = {})
      RestClient.post api_url+"/campaigns", attributes
    end

    def update_campaign(id, attributes = {})
      RestClient.put api_url+"/campaigns/#{id}", attributes
    end

    def delete_campaign(id)
      RestClient.delete api_url+"/campaigns/#{id}"
    end

    def get_campaign_events(campaign_id, params = {})
      RestClient.get api_url+"/campaigns/#{id}/events", params
    end

    def get_campaign_stats(campaign_id, params = {})
      RestClient.get api_url+"/campaigns/#{id}/stats", params
    end

    def get_campaign_clicks(campaign_id, params = {})
      RestClient.get api_url+"/campaigns/#{id}/clicks", params
    end

    def get_campaign_opens(campaign_id, params = {})
      RestClient.get api_url+"/campaigns/#{id}/opens", params
    end

    def get_campaign_unsubscribes(campaign_id, params = {})
      RestClient.get api_url+"/campaigns/#{id}/unsubscribes", params

    end

    def get_campaign_complaints(campaign_id, params = {})
      RestClient.get api_url+"/campaigns/#{id}/complaints", params
    end

    # more to come


  end
end
