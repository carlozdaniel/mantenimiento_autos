# spec/support/request_helper.rb
module RequestHelper
  def json_response
    JSON.parse(response.body)
  end
end
