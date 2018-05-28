#!/usr/bin/env ruby
#
# Produces an HTML page with enumerated links to all files in a project directory
#
require 'pathname'
require 'cgi'
require 'cgi/util'
# Load paths for gems packaged in local 'vendor' directory
Pathname('vendor/bundle/ruby').children[0].join('gems').each_child {|g| $:.unshift "#{g}/lib" }
require 'slim'

ROOT_URL = Pathname.new 'your/server/url'

template = <<~SLIM
  doctype html
  html
    head
      meta charset="utf-8"
      meta http-equiv="X-UA-Compatible" content="IE=edge"
      title
      meta name="description" content=""
      meta name="viewport" content="width=device-width, initial-scale=1"
    body
      - for v in ENV.each_pair
        p = v[0] + ' : ' + v[1]
SLIM

cgi = CGI.new
puts cgi.http_header status: 'OK'
puts Slim::Template.new {template}.render
