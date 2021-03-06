require 'find'

module Zygote
  class Runner
    def initialize(seeder:, paths:)
      @seeder = seeder
      @paths = paths
    end

    def run
      definitions.each { |definition| seeder.define(definition) }
      seeder.seed
    end

    private
    attr_reader :seeder, :paths

    def definitions
      filenames.flat_map { |filename| DefinitionsFile.new(filename).definitions }
    end

    def filenames
      Find.find(*paths).grep(/.*\.yml/)
    end

    class DefinitionsFile
      def initialize(filename)
        @filename = filename
      end

      def definitions
        definition_attributes.map { |attributes| Definition.new(attributes) }
      end

      private
      attr_reader :filename

      def definition_attributes
        yaml.map { |attributes| coerce(attributes) }
      end

      def coerce(attributes)
        attributes.deep_symbolize_keys.tap do |attrs|
          attrs[:keys].map!(&:to_sym) if attrs[:keys].present?
          attrs[:model_class] = attrs[:model_class].constantize
        end
      end

      def yaml
        File.open(filename) { |f| YAML::load(f) }
      end
    end
  end
end
