module Mutations
  class CreateOrder < GraphQL::Schema::RelayClassicMutation
    field :order, Types::OrderType, null: true,
      description: "Created order"

    field :errors, [String], null: true,
      description: "Error messages"

    argument :plane_id, ID, required: true

    def resolve(plane_id:)
      order = current_user.orders.create(plane_id: plane_id)

      {
	order: order,
	errors: order.errors.full_messages
      }
    end

    def current_user
      context[:current_user]
    end
  end
end
