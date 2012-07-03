#!/usr/bin/env ruby
#
# Simple 'tail -f' example.
# Usage example:
#   tail.rb /var/log/messages
# Pretty much direct copy of https://github.com/jordansissel/eventmachine-tail/blob/master/samples/tail.rb

require "rubygems"
require "eventmachine"
require "eventmachine-tail"
require 'statsd'

class Reader < EventMachine::FileTail
  def initialize(path, startpos=-1)
    super(path, startpos)
    puts "Tailing #{path}"
    @buffer = BufferedTokenizer.new
  end

  def receive_data(data)
    statsd = Statsd.new('localhost', 8125)
    @buffer.extract(data).each do |line|
      # Do all your fun text mangling here.
      statsd.increment('fastly.hits')
    end
  end
end

def main(args)
  if args.length == 0
    puts "Usage: #{$0} <path> [path2] [...]"
    return 1
  end

  EventMachine.run do
    args.each do |path|
      EventMachine::file_tail(path, Reader)
    end
  end
end # def main

exit(main(ARGV))