module Zygote
  class Seeder
    def initialize
      @definitions = []
    end

    def define(definition)
      definitions << definition
    end

    def seed
      definitions.each { |definition| seed_definition(definition) }
    end

    private
    attr_reader :definitions

    def seed_definition
      Upsert.perform(definition) { |seed_name| seed_named(seed_name) }
    end

    def seed_named(name)
      seed_definition(definition_named(name))
    end

    def definition_named(name)
      definitions.find { |definition| definition.name == name }
    end
  end
end
