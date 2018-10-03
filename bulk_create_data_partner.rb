# coding: utf-8
require 'csv'
require 'yaml'
require 'tsubaiso_api'

USAGE = 'usage: ruby bulk_create_data_partner.rb [csv_file]'

return puts USAGE if ARGV.size != 1

conf = YAML.load_file('./config.yml')
api = TsubaisoAPI.new(base_url: conf["base_url"], access_token: conf["access_token"])

def update(api, line)
  resp = api.show(line["resource"], id: line["id"])
  resp[:status] == '200' or raise

  code = resp[:json]["code"]
  resp = api.update(line["resource"], id: line["id"], code: code, data_partner: { id_code: line["id_code"], link_url: line["link_url"] })
  resp[:status] == '200' or raise

  { status: :ok, id: line["id"] }
rescue
  { status: :error, id: line["id"], message: resp.dig(:json, "error") }
end

results = CSV.read(ARGV[0], headers: true, skip_blanks: true)
             .map { |line| sleep(0.5); update(api, line) }
             .group_by { |result| result[:status] }

errors = results[:error].group_by { |result| result[:message] }

puts "successes: #{results[:ok]&.map { |result| result[:id] }&.join(',')}"
errors.each { |message, errors| puts "errors: #{message} ... #{errors.map { |result| result[:id] }&.join(',')}" }
