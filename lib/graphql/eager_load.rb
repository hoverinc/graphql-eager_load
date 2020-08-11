# frozen_string_literal: true

require 'graphql'
require 'graphql/eager_load/version'
require 'graphql/eager_load/builder'
require 'graphql/eager_load/resolver'

GraphQL::Schema::Resolver.include Graphql::EagerLoad::Resolver
