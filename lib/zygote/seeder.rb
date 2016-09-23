class Zygote::Seeder
  def initialize
    @definitions = []
  end

  def define(name:, model_class:, attributes:)
    definitions << Definition.new(
      name: name,
      model_class: model_class,
      attributes: attributes
    )
  end

  def seed(*names)
    names.each { |name| definition_named(name).create_or_update }
  end

  private
  attr_reader :definitions

  def definition_named(name)
    definitions.find { |definition| definition.name == name }
  end

  class Definition
    def initialize(name:, model_class:, attributes:, keys: [:id])
      @name = name
      @model_class = model_class
      @attributes = attributes
      @keys = keys
    end

    attr_reader :name, :model_class, :attributes, :keys

    def create_or_update
      model_class
        .where(key_attributes)
        .first_or_initialize
        .update!(attributes)
    end

    def key_attributes
      attributes.slice(*keys)
    end
  end
end
