# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  begin
    lando_services = JSON.parse(`lando info --format json`, symbolize_names: true)
    lando_services.each do |service|
      case service[:service]
        when "test_solr"
          ENV["lando_test_solr"] = "http://#{service[:external_connection][:host]}:#{service[:external_connection][:port]}/solr/#{service[:core]}"
        when "development_solr"
          ENV["lando_development_solr"] = "http://#{service[:external_connection][:host]}:#{service[:external_connection][:port]}/solr/#{service[:core]}"
      end
    end
  rescue StandardError
    nil
  end
end