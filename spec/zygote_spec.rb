require 'spec_helper'

describe Zygote do

  describe "VERSION" do
    specify { expect(Zygote::VERSION).to be_present }
  end

  describe ".seed" do
    before do
      define_active_record_class("SeededModel") { |t| t.string :name }
    end

    it "loads all seed files" do
      Zygote.seed(File.dirname(__FILE__) + '/fixtures')

      expect(SeededModel.all).to contain_exactly(
        an_object_having_attributes(id: 1, name: "simple model"),
        an_object_having_attributes(id: 2, name: "named model"),
        an_object_having_attributes(id: 3, name: "keyed model"),
      )
    end
  end

end
