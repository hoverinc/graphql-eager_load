# frozen_string_literal: true

require 'bundler'
require 'bundler/setup'
require 'graphql/eager_loader'

Bundler.require :default, :development

Combustion.initialize! :all, load_schema: true, database_migrate: true, database_reset: true

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
