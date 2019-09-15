require 'rails_helper'

describe Types::UserType, type: :request do
  include ApiHelpers

  let(:user) { create :user }
  let(:plane) { create :plane, :with_unoccupied_seats }
  let!(:order) { create :order, plane: plane, user: user }
  let(:collection) { 'currentUser' }
  let(:fields) { 'username email orders { id }' }
  let(:query) { "query { #{collection} { #{fields} } }" }

  it '401 when unauthenticated' do
    #post("graphql", { query: query }.to_query)
    post "/graphql", params: { query: query }.to_query

    expect(response.status).to eq(401)
  end

  it 'get all expected data when authenticated' do
    headers = user_login(user)

    post "/graphql", params: { query: query }.to_query, headers: headers

    expect(json_response).to eq(
      data: {
	currentUser: {
	  username: user.username,
	  email: user.email,
	  orders: [{
	    id: order.id.to_s
	  }]
	}
      }
    )
  end
end
