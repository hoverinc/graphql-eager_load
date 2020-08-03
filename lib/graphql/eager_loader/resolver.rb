# frozen_string_literal: true

module Graphql
  module EagerLoader
    # Automatically included in any subclasses of Resolvers::Base
    module Resolver
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      def associations_to_include
        graphql_eager_load_options(model: @@eager_load_model)
      end

      def graphql_eager_load_options(selections: context.query.lookahead.selections, model:)
        Builder.call(selections: selections, model: model)
      end

      # specify the ActiveRecord model that corresponds to the top level type
      # in the graphql query for this resolver.
      module ClassMethods
        def eager_load_model(model)
          @eager_load_model = model
        end
      end
    end
  end
end
