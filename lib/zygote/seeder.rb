module Zygote
  class Seeder
    def initialize
      @definitions = []
    end

    def define(definition)
      definitions << definition
    end

    def seed
      definitions.each { |definition| Upsert.perform(definition) }
    end

    private
    attr_reader :definitions
  end
end
