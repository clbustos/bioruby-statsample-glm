require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'statsample-glm'


RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end


def expect_similar_vector(exp, obs, delta=1e-10,msg=nil)
  expect(exp.size).to eq(obs.size)

  exp.data_with_nils.each_with_index do |v,i|
    expect(v).to be_within(delta).of(obs[i])
  end
end

def expect_similar_hash(exp, obs, delta=1e-10,msg=nil)
  expect(exp.size).to eq(obs.size)

  exp.each_key do |k|
    expect(exp[k]).to be_within(delta).of(obs[k])
  end
end

def expect_equal_vector(exp,obs,delta=1e-10,msg=nil)
  expect(exp.size).to eq(obs.size)

  exp.size.times do |i|
    expect(exp[i]).to be_within(delta).of(obs[i])
  end
end

def expect_equal_matrix(exp,obs,delta=1e-10,msg=nil)
  expect(exp.row_size).to eq(obs.row_size)
  expect(exp.column_size).to eq(obs.column_size)

  exp.row_size.times do |i|
    exp.column_size.times do |j|
      expect(exp[i,j]).to be_within(delta).of(obs[i,j])    
    end
  end
end
