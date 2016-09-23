require 'spec_helper'

describe Zygote do

  describe "VERSION" do
    specify { expect(Zygote::VERSION).to be_present }
  end

  describe ".seed" do
    before do
      define_active_record_class("SeededModel") do |t|
        t.string :name
      end
    end

    it "creates a new seed" do
      expect(false).to eq(true)
    end
  end

end
