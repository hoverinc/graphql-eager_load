# frozen_string_literal: true

require 'graphql'
require 'graphql/eager_loader/version'
require 'graphql/eager_loader/builder'
require 'graphql/eager_loader/resolver'

GraphQL::Schema::Resolver.include Graphql::EagerLoader::Resolver
