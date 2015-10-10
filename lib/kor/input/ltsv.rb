require 'kor'
require 'ltsv'

module Kor
  module Input
    class Ltsv
      DEFAULT_GUESS_TIME = 5

      def initialize(io)
        @io = io
        @keys = []
        @prekeys = nil
        @ltsvs = []
        @guess = true
        @guess_time = DEFAULT_GUESS_TIME
        @count = 0
        @fiber = Fiber.new do
          @ltsvs.each do |ltsv|
            Fiber.yield @keys.map{ |k| ltsv[k] }
          end
          # gets should be return nil when last
          Fiber.yield nil
        end
      end

      def parse(opt)
        opt.on("--key=KEY", "define keys preset (e.g. foo,bar,baz) (default auto)") do |arg|
          @prekeys = arg
        end
        opt.on("--guess-time=NUM", "load lines this time for guess. no guess if under 0 (default #{DEFAULT_GUESS_TIME})") do |arg|
          @guess_time = arg.to_i
        end
      end

      def head
        if @prekeys
          @keys = @prekeys.split(",")
        else
          while line = @io.gets
            line.strip!
            @ltsvs << parse_line(line)
            if 0 < @guess_time && @guess_time <= @ltsvs.length
              break
            end
          end
          @keys = @ltsvs.map { |ltsv| ltsv.keys }
          @keys.flatten!.uniq!
        end
        @keys
      end

      def gets
        if @prekeys
          if line = @io.gets
            line.strip!
            ltsv = parse_line(line)
            @keys.map { |k| ltsv[k] }
          else
            nil
          end
        elsif 0 < @guess_time
          if @count < @guess_time
            @count += 1
            return resume
          end
          if line = @io.gets
            line.strip!
            ltsv = parse_line(line)
            @keys.map { |k| ltsv[k] }
          end
        else
          resume
        end
      end

      def parse_line(line)
        LTSV.parse(line, symbolize_keys: false).first
      end

      def resume
        @fiber.resume
      rescue FiberError
        nil
      end
    end

    require "kor/input/ltsv/version"
  end
end
