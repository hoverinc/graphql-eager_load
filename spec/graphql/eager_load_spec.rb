# frozen_string_literal: true

RSpec.describe Graphql::EagerLoad do
  it 'has a version number' do
    expect(Graphql::EagerLoad::VERSION).not_to be nil
  end

  describe '.call' do
    subject(:options) do
      resolver.graphql_eager_load_options(model: model)
    end

    let(:resolver) { resolver_class.new }
    let(:resolver_class) do
      closure_query = query
      closure_model = model

      Class.new do
        include Graphql::EagerLoad::Resolver
        eager_load_model closure_model

        define_method(:context) do
          OpenStruct.new(query: closure_query)
        end
      end
    end

    let(:query) { GraphQL::Query.new(InternalSchema, query_string) }
    let(:selections) { query.lookahead.selections }

    describe 'single record, has_many' do
      let(:model) { ::Job }
      let(:query_string) do
        <<-QUERY
        query {
          jobs {
            user { id }
          }
        }
        QUERY
      end

      it do
        expect(options).to eq(user: {})
      end
    end

    describe 'no pagination, has_many' do
      let(:model) { ::User }
      let(:query_string) do
        <<-QUERY
        query {
          users {
            nodes {
              id
              jobs { id }
            }
          }
        }
        QUERY
      end

      it do
        expect(options).to eq(jobs: {})
      end
    end

    describe 'cursor based pagination, has_many, belongs_to, attachment' do
      let(:model) { ::User }
      let(:query_string) do
        <<-QUERY
        query {
          users {
            nodes {
              id
              photo { filename }
              jobs {
                id
                user { id }
              }
              proposalDocuments { id }
              order { code }
            }
            pageInfo { hasNextPage }
          }
        }
        QUERY
      end

      it do
        expect(options).to eq(
          proposal_documents: {},
          jobs: { user: {} },
          photo_attachment: { blob: {} }
        )
      end
    end
  end
end
