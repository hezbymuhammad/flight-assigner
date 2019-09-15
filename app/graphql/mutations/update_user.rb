module Mutations
  class UpdateUser < GraphQL::Schema::RelayClassicMutation
    field :user, Types::UserType, null: true,
      description: "Updated user"

    field :errors, [String], null: true,
      description: "Error messages"

    argument :id, ID, required: true
    argument :username, String, required: false
    argument :email, String, required: false
    argument :password, String, required: false

    def resolve(id:, **args)
      user = User.find(id)
      user.update(args)

      {
	user: user,
	errors: user.errors.full_messages
      }
    end
  end
end
