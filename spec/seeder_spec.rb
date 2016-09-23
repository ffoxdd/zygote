require 'spec_helper'

describe Zygote::Seeder do

  describe ".define/.seed" do
    before do
      define_active_record_class("SeededModel") do |t|
        t.string :name
      end
    end

    let(:seeder) { Zygote::Seeder.new }

    it "creates a new seed" do
      seeder.define(
        name: :simple_seed,
        model_class: SeededModel,
        attributes: {name: "simple seed"}
      )

      seeder.seed(:simple_seed)

      expect(SeededModel.all).to contain_exactly(
        an_object_having_attributes(name: "simple seed")
      )
    end

    it "updates an existing seed by id" do
      SeededModel.create!(name: "old name")

      seeder.define(
        name: :changed_seed,
        model_class: SeededModel,
        attributes: {name: "new name"}
      )

      seeder.seed(:changed_seed)

      expect(SeededModel.all).to contain_exactly(
        an_object_having_attributes(name: "new name")
      )
    end
  end

end
