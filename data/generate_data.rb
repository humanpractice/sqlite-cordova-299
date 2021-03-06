#!/usr/bin/env ruby

require 'csv'
require 'json'

DATA_FILE = File.expand_path('../FakeNameGenerator.com_0dae316a/FakeNameGenerator.com_0dae316a.csv', __FILE__)
OUTPUT_FILE = File.expand_path('../../www/js/data.js', __FILE__)
LIMIT=8_000

def documents
  docs = []
  CSV.foreach(DATA_FILE, headers: true) do |csv|
    break if (docs.size >= LIMIT)
    docs << {
      _id: csv['GUID'],
      given_name: csv['GivenName'],
      surname: csv['Surname'],
      email_address: csv['EmailAddress'],
      city: csv['City'],
      national_id: csv['NationalID']
    }
  end
  docs
end

def create_javascript_source
  File.open(OUTPUT_FILE, 'w') do |f|
    f.write "var DATA = "
    f.puts JSON.pretty_generate(documents)
  end
end

create_javascript_source
