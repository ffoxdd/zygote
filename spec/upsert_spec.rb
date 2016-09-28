require 'spec_helper'

RSpec.describe Zygote::Upsert do

  describe ".perform" do
    before do
      define_active_record_class("SeededModel") do |t|
        t.string :name
        t.integer :value
      end
    end

    context "new record" do
      it "creates a new seed according to the definition" do
        definition = Zygote::Definition.new(
          model_class: SeededModel, attributes: {id: 2, name: "new-seed", value: 10}
        )

        Zygote::Upsert.perform(definition)

        expect(SeededModel.all).to contain_exactly(
          an_object_having_attributes(id: 2, name: "new-seed", value: 10)
        )
      end
    end

    context "existing record" do
      before do
        definition = Zygote::Definition.new(
          model_class: SeededModel, attributes: {id: 2, name: "existing-seed", value: 10}
        )

        Zygote::Upsert.perform(definition)
      end

      it "updates an existing seed by id" do
        definition = Zygote::Definition.new(
          model_class: SeededModel, attributes: {id: 2, name: "updated-seed"}
        )

        Zygote::Upsert.perform(definition)

        expect(SeededModel.all).to contain_exactly(
          an_object_having_attributes(id: 2, name: "updated-seed", value: 10)
        )
      end

      it "updates an existing seed by keys" do
        definition = Zygote::Definition.new(
          model_class: SeededModel, keys: [:value], attributes: {name: "updated-seed", value: 10}
        )

        Zygote::Upsert.perform(definition)

        expect(SeededModel.all).to contain_exactly(
          an_object_having_attributes(id: 2, name: "updated-seed", value: 10)
        )
      end
    end
  end

end
