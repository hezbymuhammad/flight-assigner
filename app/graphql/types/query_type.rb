module Types
  class QueryType < Types::BaseObject
    field :current_user, UserType, null: false,
      description: "An example field added by the generator"

    def current_user
      context[:current_user].attributes
    end
  end
end
