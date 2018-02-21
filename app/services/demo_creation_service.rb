require 'net/http'
require 'json'

# Service for creating DemoForms
class DemoCreationService
  attr_reader :login, :api_key

  def initialize
    config = Config.current
    @login = config.login
    @api_key = config.api_key
  end

  def call(args = {})
    header = {'Content-Type': 'application/json'}
    uri = URI(base_uri)
    req = Net::HTTP::Post.new(uri, header)
    req.body = {"add":[{"source_name":"http://workandplay.ru/","source_uid":"11","created_at":Time.now.to_i,"incoming_entities":{"leads":[{"name":args[:username]}]},"incoming_lead_info":{"form_id":"1","form_page":"http://workandplay.ru/","ip":"localhost","service_code":"1"}}]}.to_json
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
    JSON.parse(response.body)
  end

  private def base_uri
    "https://workandplay.amocrm.ru/api/v2/incoming_leads/form?login=#{login}&api_key=#{api_key}"
  end
end
