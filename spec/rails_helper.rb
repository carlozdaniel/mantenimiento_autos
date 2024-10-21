# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'devise'  # <-- Añadido este require

# Incluir archivos de soporte (como request_helper)
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Habilitar transaction fixtures para tests que usen la base de datos
  config.use_transactional_fixtures = true

  # Incluir FactoryBot para usar métodos como `create` y `build`
  config.include FactoryBot::Syntax::Methods

  # Incluir helpers específicos para pruebas de tipo request
  config.include RequestHelper, type: :request

  # Incluir helpers de Devise para pruebas de controladores
  config.include Devise::Test::ControllerHelpers, type: :controller

  # Incluir helpers de Devise para pruebas de tipo request
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Inferir el tipo de prueba según la ubicación del archivo
  config.infer_spec_type_from_file_location!

  # Filtrar trazas de gemas Rails para reducir ruido en los errores
  config.filter_rails_from_backtrace!
end
