require "zygote/version"
require "active_record"

module Zygote
  autoload :VERSION, "zygote/version"
  autoload :Seeder, "zygote/seeder"
  autoload :Definition, "zygote/definition"
  autoload :Runner, "zygote/runner"
  autoload :Upsert, "zygote/upsert"

  mattr_accessor :seed_paths
  @@seed_paths = ['db/seeds']

  def self.define(**arguments)
    seeder.define(**arguments)
  end

  def self.seed(seed_paths = Zygote.seed_paths)
    Runner.new(seeder: seeder, paths: seed_paths).run
  end

  def self.seeder
    @@seeder ||= Seeder.new
  end
end
