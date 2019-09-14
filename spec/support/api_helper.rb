module ApiHelpers
  def user_login(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    {
      'Authorization': "Bearer #{token}"
    }
  end

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end
end
