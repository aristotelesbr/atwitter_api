# frozen_string_literal: true

require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader'
require 'sinatra/namespace'
require 'mongoid'

Mongoid.load! 'mongoid.config'

class Atweet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :author, type: String, default: 'ANON'
  field :content, type: String
  field :image, type: String
  field :tags, type: Array, default: []
  field :likes, type: Integer, default: 0
end

get ('/api/v1/atweets') { Atweet.all.to_json }

post '/api/v1/atweets' do
  new_atweet = Atweet.new(JSON.parse(request.body.read)).save
  new_atweet.to_json
end
