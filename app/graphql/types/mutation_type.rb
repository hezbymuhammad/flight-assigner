module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::UpdateUser,
      description: "Create new user"
  end
end
