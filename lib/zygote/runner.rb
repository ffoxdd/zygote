require 'find'

class Zygote::Runner
  def initialize(seeder:, paths:)
    @seeder = seeder
    @paths = paths
  end

  def run
    load_seed_files
    seeder.seed_all
  end

  private
  attr_reader :seeder, :paths

  def load_seed_files
    filenames.each { |filename| load_file(filename) }
  end

  def load_file(filename)
    ActiveRecord::Base.transaction do
      File.open(filename) { |f| eval(f.read) }
    end
  end

  def filenames
    Find.find(*paths).grep(/.*\.rb/).sort
  end
end
