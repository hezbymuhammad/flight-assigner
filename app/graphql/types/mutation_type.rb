module Types
  class MutationType < Types::BaseObject
    field :update_user, mutation: Mutations::UpdateUser,
      description: "Create new user"
    field :create_order, mutation: Mutations::CreateOrder,
      description: "Create new order"
  end
end
