require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/config_file'
require './p90x'

set :run, false
set :raise_errors, true

run P90X
