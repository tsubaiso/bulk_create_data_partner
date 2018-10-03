# coding: utf-8
require 'csv'
#require 'tsubaiso_sdk'
require '../../tsubaiso-sdk-ruby/lib/tsubaiso_api'

USAGE = 'usage: ruby bulk_create_data_partner.rb [csv_file]'

return puts USAGE if ARGV.size != 1

api = TsubaisoAPI.new(base_url: 'http://burikama.tech/tsubaiso.chris_review/eap/', access_token: '6i45jovi7xwvheoa5bzxj25ni-1ay4oo7fxyykmwvwb5ddxpbt0')

success_codes, errors = [], []

CSV.foreach(ARGV[0], headers: true, skip_blanks: true) do |line|
  sleep 0.5
  # TODO: 多分、IDじゃないと汎用的じゃない
  resp = api.show(line['resource'], code: line['code'])
  resp[:status] == '200' or raise

  object = resp[:json]

  resp = api.update('customer_masters', id: object["id"], code: object["code"], data_partner: { id_code: line["id_code"], link_url: line["link_url"] })
  resp[:status] == '200' or raise

  success_codes << line["code"]

rescue
  errors << "#{line["code"]}: #{resp.dig(:json, "error")}"
end

puts "successes: #{success_codes}"
puts <<EOS
errors:
#{errors.join("\n")}
EOS

