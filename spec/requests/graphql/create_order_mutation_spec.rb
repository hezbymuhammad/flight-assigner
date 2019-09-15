require 'rails_helper'

describe Mutations::CreateOrder, type: :request do
  include ApiHelpers

  let(:user) { create :user }
  let(:collection) { 'createOrder' }
  let(:plane) { create :plane }
  let!(:seat) { create :seat, plane: plane, occupied: false }
  let(:inputs) { "planeId: #{plane.id}" }
  let(:fields) { 'errors order { id plane { name } seat { code queueNumber } }' }
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
	createOrder: {
	  errors: [],
	  order: {
	    id: Order.last.id.to_s,
	    plane: {
	      name: plane.name
	    },
	    seat: {
	      code: seat.code,
	      queueNumber: seat.queue_number
	    }
	  }
	}
      }
    )
  end
end
