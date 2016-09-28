require 'spec_helper'

describe Zygote::Seeder do

  let(:seeder) { Zygote::Seeder.new }

  describe "#define/#seed" do
    let(:definition_1) { double(:definition_1) }
    let(:definition_2) { double(:definition_2) }

    it "upserts defined seeds" do
      expect(Zygote::Upsert).to receive(:perform).with(definition_1)
      expect(Zygote::Upsert).to receive(:perform).with(definition_2)

      seeder.define(definition_1)
      seeder.define(definition_2)

      seeder.seed
    end
  end

end
