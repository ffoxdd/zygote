require 'spec_helper'

describe Zygote do

  describe "VERSION" do
    specify { expect(Zygote::VERSION).to be_present }
  end

  describe ".seed" do
    before do
      define_table(:seeded_models) do |t|
        t.string :name
        t.integer :parent_id
      end

      define_active_record_class("SeededModel") do
        belongs_to :parent, class_name: "SeededModel"
      end
    end

    it "loads all seed files" do
      Zygote.seed(File.dirname(__FILE__) + '/fixtures')

      expect(SeededModel.all).to contain_exactly(
        an_object_having_attributes(id: 1, name: "simple model"),
        an_object_having_attributes(id: 2, name: "named model"),
        an_object_having_attributes(id: 3, name: "keyed model"),

        an_object_having_attributes(
          id: 4,
          name: "model with association",
          parent: an_object_having_attributes(name: "named model")
        )
      )
    end
  end

end
