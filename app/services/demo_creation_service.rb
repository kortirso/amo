require 'httparty'

# Service for creating DemoForms
class DemoCreationService
  include HTTParty
  base_uri 'https://workandplay.amocrm.ru'

  attr_reader :login, :api_key, :cookies

  def initialize
    config = Config.current
    @login = config.login
    @api_key = config.api_key
  end

  def auth
    body = {'USER_LOGIN':login,'USER_HASH':api_key}

    response = self.class.post('/private/api/auth.php?type=json', body: body)
    @cookies = response.headers['set-cookie']
    response.parsed_response
  end

  def get_leads
    response = self.class.get("/api/v2/incoming_leads?login=#{login}&api_key=#{api_key}")
    JSON.parse(response.parsed_response)
  end

  def create_lead(args = {})
    body = {"add":[{"source_name":"http://workandplay.ru","source_uid":"1","created_at":Time.now.to_i,"incoming_entities":{"leads":[{"name":'userio'}]},"incoming_lead_info":{"form_id":"1","form_page":"http://workandplay.ru","ip":"localhost","service_code":"1"}}]}
    headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8', 'Cookie': cookies}

    response = self.class.post("/api/v2/incoming_leads/form?login=#{login}&api_key=#{api_key}", body: body, headers: headers)
    JSON.parse(response.parsed_response)
  end
end
