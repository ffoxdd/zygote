require 'spec_helper'

describe Zygote::Definition do

  it "sets name, model_class, attributes, keys" do
    definition = Zygote::Definition.new(
      name: "the-definition",
      model_class: Object,
      keys: [:an_attribute],
      attributes: {id: 1, an_attribute: "value"}
    )

    expect(definition).to have_attributes(
      name: "the-definition",
      model_class: Object,
      keys: [:an_attribute],
      attributes: {id: 1, an_attribute: "value"}
    )
  end

  it "can be instantiated without a name" do
    definition = Zygote::Definition.new(
      model_class: Object,
      attributes: {id: 1}
    )

    expect(definition).to have_attributes(name: nil)
  end

  it "defaults keys to [:id]" do
    definition = Zygote::Definition.new(
      model_class: Object,
      attributes: {id: 1}
    )

    expect(definition).to have_attributes(keys: [:id])
  end

  it "raises an error if all keys are not specified" do
    expect {
      Zygote::Definition.new(
        model_class: Object,
        keys: [:key_1, :key_2],
        attributes: {key_1: "value"}
      )
    }.to raise_error(ArgumentError)
  end

end
