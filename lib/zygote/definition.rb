class Zygote::Definition
  def initialize(name: nil, model_class:, keys: [:id], attributes:)
    @name = name
    @model_class = model_class
    @attributes = attributes
    @keys = keys

    raise ArgumentError unless all_keys_specified?
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

  private

  def all_keys_specified?
    keys.all? { |key| attributes.has_key?(key) }
  end
end
