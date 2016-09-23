require 'spec_helper'

describe Zygote do

  describe "VERSION" do
    specify { expect(Zygote::VERSION).to be_present }
  end

end
