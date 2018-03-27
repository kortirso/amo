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

  def create_contact(args = {})
    body = {"add":[{"name":args[:username],"custom_fields":[{"id":157423,"values":[{"value":args[:phone],"enum":"MOB"}]},{"id":157425,"values":[{"value":args[:email],"enum":"WORK"}]}]}]}

    headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8', 'Accept': 'application/json', 'Cookie': cookies}

    response = self.class.post("/api/v2/contacts?login=#{login}&api_key=#{api_key}", body: body, headers: headers)
    JSON.parse(response.parsed_response)
  end

  def create_lead(args = {})
    body = {"add":[{"name":"name - #{args[:username]}, email - #{args[:email]}, phone - #{args[:phone]}, utm - #{args[:utm]}","custom_fields":[{"id":209003,"values":[{"value":args[:utm]}]}]}]}
    headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8', 'Accept': 'application/json', 'Cookie': cookies}

    response = self.class.post("/api/v2/leads?login=#{login}&api_key=#{api_key}", body: body, headers: headers)
    JSON.parse(response.parsed_response)
  end
end
