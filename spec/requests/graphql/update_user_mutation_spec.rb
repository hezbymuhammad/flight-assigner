require 'rails_helper'

describe Mutations::UpdateUser, type: :request do
  include ApiHelpers

  let(:user) { create :user }
  let(:collection) { 'createUser' }
  let(:username) { FFaker::Internet.user_name }
  let(:email) { FFaker::Internet.email }
  let(:inputs) { "id: #{user.id} username: \"#{username}\" email: \"#{email}\" " }
  let(:fields) { 'errors user { username email }' }
  let(:query) { "mutation { #{collection} ( input: { #{inputs} } ) { #{fields} } }" }

  it '401 when unauthenticated' do
    post "/graphql", params: { query: query }.to_query

    expect(response.status).to eq(401)
  end

  it 'can update when authenticated' do
    headers = user_login(user)

    post "/graphql", params: { query: query }.to_query, headers: headers

    expect(json_response).to eq(
      data: {
	createUser: {
	  errors: [],
	  user: {
	    username: username,
	    email: email
	  }
	}
      }
    )
  end
end
