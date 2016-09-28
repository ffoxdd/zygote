require 'spec_helper'

describe Zygote::Seeder do

  let(:seeder) { Zygote::Seeder.new }

  describe "#define" do
    it "raises an error when keys are not specified" do
      expect {
        definition = Zygote::Definition.new(
          name: :seed_name,
          model_class: Object,
          keys: [:id],
          attributes: {name: "name"}
        )

        seeder.define(definition)
      }.to raise_error(ArgumentError)
    end

    it "can define a seed without a name" do
      expect {
        definition = Zygote::Definition.new(model_class: Object, attributes: {id: 1})
        seeder.define(definition)
      }.to_not raise_error
    end
  end

  describe "#seed" do
    it "seeds all definitions" do
      define_active_record_class("SeededModel")

      definitions = [
        Zygote::Definition.new(model_class: SeededModel, attributes: {id: 1}),
        Zygote::Definition.new(model_class: SeededModel, attributes: {id: 2})
      ]

      definitions.each { |definition| seeder.define(definition) }

      seeder.seed

      expect(SeededModel.all).to contain_exactly(
        an_object_having_attributes(id: 1),
        an_object_having_attributes(id: 2)
      )
    end
  end
end
