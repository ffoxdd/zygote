require 'spec_helper'

describe Zygote::Seeder do

  let(:seeder) { Zygote::Seeder.new }

  describe "#define" do
    it "raises an error when keys are not specified as arguments" do
      expect {
        seeder.define(
          name: :seed_name,
          model_class: Object,
          keys: [:id],
          attributes: {name: "name"}
        )
      }.to raise_error(ArgumentError)
    end

    it "can define a seed without a name" do
      expect {
        seeder.define(model_class: Object, attributes: {id: 1})
      }.to_not raise_error
    end
  end

  describe "#seed" do
    context "create" do
      it "creates a new seed when one doesn't already exist" do
        define_active_record_class("SeededModel") { |t| t.string :name }

        seeder.define(
          name: :new_seed,
          model_class: SeededModel,
          attributes: {id: 1, name: "new seed"}
        )

        seeder.seed(:new_seed)

        expect(SeededModel.all).to contain_exactly(
          an_object_having_attributes(id: anything, name: "new seed")
        )
      end
    end

    context "update" do
      it "updates an existing seed by id" do
        define_active_record_class("SeededModel") { |t| t.string :name }

        SeededModel.create!(id: 3, name: "old name")

        seeder.define(
          name: :changed_seed,
          model_class: SeededModel,
          attributes: {id: 3, name: "new name"}
        )

        seeder.seed(:changed_seed)

        expect(SeededModel.all).to contain_exactly(
          an_object_having_attributes(name: "new name")
        )
      end

      it "updates an existing seed by keys" do
        define_active_record_class("SeededModel") do |t|
          t.integer :x
          t.integer :y
          t.integer :value
        end

        SeededModel.create!(x: 1, y: 2, value: 100)

        seeder.define(
          name: :keyed_seed,
          model_class: SeededModel,
          keys: [:x, :y],
          attributes: {x: 1, y: 2, value: 200}
        )

        seeder.seed(:keyed_seed)

        expect(SeededModel.all).to contain_exactly(
          an_object_having_attributes(x: 1, y: 2, value: 200)
        )
      end
    end
  end

end
