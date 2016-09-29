class Zygote::Upsert
  def initialize(definition)
    @definition = definition
  end

  def self.perform(definition, &block)
    new(definition).perform(&block)
  end

  def perform(&block)
    model_class
      .where(key_attributes)
      .first_or_initialize
      .update!(attributes(&block))
  end

  private

  attr_reader :definition
  delegate :model_class, :key_attributes, to: :definition

  def attributes(&block)
    attributes.merge(belongs_to_attributes(&block))
  end

  def belongs_to_attributes(&block)
    # TODO: do something here
  end
end
