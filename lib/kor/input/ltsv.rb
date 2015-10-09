require 'kor'

module Kor
  module Input
    class Ltsv
      class LTSV < Hash
        DELIM = "\t".freeze
        SPLIT = ":".freeze

        def self.parse(line)
          LTSV[line.split(DELIM).map{ |i| i.split(SPLIT, 2) }]
        end
      end

      def initialize(io)
        @io = io
        @keys = []
        @prekeys = nil
        @ltsvs = []
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
      end

      def head
        if @prekeys
          @keys = @prekeys.split(",")
        else
          while line = @io.gets
            line.strip!
            @ltsvs << LTSV.parse(line)
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
            ltsv = LTSV.parse(line)
            @keys.map { |k| ltsv[k] }
          else
            nil
          end
        else
          begin
            @fiber.resume
          rescue FiberError
            nil
          end
        end
      end
    end

    require "kor/input/ltsv/version"
  end
end
