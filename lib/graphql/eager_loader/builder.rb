# frozen_string_literal: true

module Graphql
  module EagerLoader
    #
    # Given
    #   - An initial set of includes, a hash
    #   - GraphQL query selections
    #   - The model corresponding to the type returned by a GraphQL resolver
    #
    # This module will iterate and recurse into the selctions to find out if
    # any of the fields requested for a given type corresponds to an
    # association on the ActiveRecord model associated with the field's type.
    #
    #
    # For example given this query
    #
    # salesOpportunities() {
    #   soldEstimateGroup {
    #     estimates {
    #      lineItems
    #     }
    #   }
    # }
    #
    # We'd return this "includes" hash
    #
    # {sold_estimate_group: {estimates: {line_items: {}}}}
    #
    # And our resolver will use it like `scope.includes(includes)` to
    # prevent N+1s
    #
    class Builder
      def self.call(selections:, model:)
        selections.each.with_object({}) do |selection, includes|
          builder = new(selection: selection, model: model)

          if builder.association?
            includes[builder.association_name] = builder.includes
          else
            includes.merge!(builder.includes)
          end
        end
      end

      def initialize(selection:, model:)
        @selection = selection
        @model = model
      end

      def includes
        self.class.call(selections: selection.selections, model: includes_model)
      end

      def association?
        association.present?
      end

      def association_name
        association.name
      end

      private

      attr_reader :selection, :model

      def includes_model
        return ActiveStorage::Attachment if active_storage_attachment?

        association&.klass || model
      end

      def association
        return if use_custom_method?
        return model.reflect_on_association("#{field_name}_attachment") if active_storage_attachment?

        model.reflect_on_association(field_name)
      end

      def active_storage_attachment?
        model.reflect_on_attachment(field_name).present?
      end

      def use_custom_method?
        custom_method_defined? && !ignore_custom_method?
      end

      def ignore_custom_method?
        return false unless field_owner.respond_to?(:allow_include_builder_fields)

        field_owner.allow_include_builder_fields&.include?(field_name.to_sym)
      end

      def custom_method_defined?
        field_owner.instance_methods.include?(field_name)
      end

      def field_owner
        selection.field.owner
      end

      def field_name
        selection.name
      end
    end
  end
end
