require 'spec_helper'

describe Zygote::Seeder do

  describe ".define/.seed" do
    let(:seeder) { Zygote::Seeder.new }

    it "creates a new seed" do
      define_active_record_class("SeededModel") { |t| t.string :name }

      seeder.define(
        name: :simple_seed,
        model_class: SeededModel,
        attributes: {name: "simple seed"}
      )

      seeder.seed(:simple_seed)

      expect(SeededModel.all).to contain_exactly(
        an_object_having_attributes(id: anything, name: "simple seed")
      )
    end

    it "can set the id" do
      define_active_record_class("SeededModel") { |t| }

      seeder.define(
        name: :simple_seed,
        model_class: SeededModel,
        attributes: {id: 3}
      )

      seeder.seed(:simple_seed)

      expect(SeededModel.all).to contain_exactly(
        an_object_having_attributes(id: 3)
      )
    end

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
