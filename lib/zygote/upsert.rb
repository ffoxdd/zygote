class Zygote::Upsert
  def initialize(definition)
    @definition = definition
  end

  def self.perform(definition)
    new(definition).perform
  end

  def perform
    model_class
      .where(key_attributes)
      .first_or_initialize
      .update!(attributes)
  end

  private

  attr_reader :definition
  delegate :model_class, :key_attributes, :attributes, to: :definition
end
