#!/bin/env ruby
# encoding: utf-8

require 'colorize'
require 'csv'
require 'scraperwiki'
require 'pry'

# require 'open-uri/cached'
# OpenURI::Cache.cache_path = '.cache'

def reprocess_csv(file)
  raw = open(file).read
  csv = CSV.parse(raw, headers: true, header_converters: :symbol)
  csv.each do |row|
    data = row.to_hash.each { |k, v| v = v.to_s.gsub(/[[:space:]]+/, ' ').strip }
    data[:term] = '2012'
    data[:source] = 'http://www.telema.org/pdf/telema_deputes_rdc.pdf'
    ScraperWiki.save_sqlite([:id, :name, :term], data)
  end
end

csv_data = reprocess_csv('https://docs.google.com/spreadsheets/d/1VNu0F8loXEv5AhXiWdwLrajpY_aPTOVAHOaTddb323w/export?format=csv&gid=644548854')
