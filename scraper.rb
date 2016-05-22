#!/bin/env ruby
# encoding: utf-8

require 'colorize'
require 'csv'
require 'scraperwiki'
require 'pry'

def gender_for(str)
  return if str.to_s.empty?
  return 'male' if str.downcase == 'm'
  return 'female' if str.downcase == 'f'
  warn "Unknown gender: #{str}"
end

def reprocess_csv(file)
  raw = open(file).read
  csv = CSV.parse(raw, headers: true, header_converters: :symbol)
  csv.each do |row|
    data = row.to_hash.each { |k, v| v = v.to_s.gsub(/[[:space:]]+/, ' ').strip }
    data[:gender] = gender_for(data[:gender])
    data[:term] = '2012'
    ScraperWiki.save_sqlite([:id, :name, :term], data)
  end
end

csv_data = reprocess_csv('https://docs.google.com/spreadsheets/d/1VNu0F8loXEv5AhXiWdwLrajpY_aPTOVAHOaTddb323w/export?format=csv&gid=644548854')
