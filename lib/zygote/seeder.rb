class Zygote::Seeder
  def initialize
    @definitions = []
  end

  def define(definition)
    definitions << definition
  end

  def seed(*names)
    names.each { |name| definition_named(name).create_or_update }
  end

  def seed_all
    definitions.each(&:create_or_update)
  end

  private
  attr_reader :definitions

  def definition_named(name) # TODO: memoize
    definitions.find { |definition| definition.name == name }
  end
end
