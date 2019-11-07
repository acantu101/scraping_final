#!/usr/bin/env ruby

# require "bundler/setup"
# require "kefoto_scraper/CLI.rb"
# require "kefoto_scraper/version"

require_relative "../lib/kefoto.rb"

KefotoScraper::CLI.new.call
