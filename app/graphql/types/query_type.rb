module Types
  class QueryType < Types::BaseObject
    field :current_user, UserType, null: false,
      description: "Logged in user"

    def current_user
      context[:current_user].attributes
    end
  end
end
