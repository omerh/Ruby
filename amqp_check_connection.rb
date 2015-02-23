#!/usr/bin/env ruby
# encoding: utf-8

require 'amqp'

EventMachine.run do
  connection = AMQP.connect(:host => '0.0.0.0', :user => 'guest', :password => 'guest', :logging => true)
  puts "Connecting to RabbitMQ. Running #{AMQP::VERSION} version of the gem..."

  ch  = AMQP::Channel.new(connection)
  q   = ch.queue("amqpgem.examples.hello_world", :auto_delete => false)
  x   = ch.default_exchange

  q.subscribe do |metadata, payload|
    puts "Received a message: #{payload}. Disconnecting..."

    connection.close {
      EventMachine.stop { exit }
    }
  end

  x.publish "Hello, world!", :routing_key => q.name
end
