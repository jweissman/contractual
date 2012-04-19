# -*- encoding: utf-8 -*-
require File.expand_path('../lib/contractual/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joseph Weissman"]
  gem.email         = ["jweissman1986@gmail.com"]
  gem.description   = %q{This gem provides limited support for the utilization of interfaces in Ruby. The approach here is 
  nearly idetnical to one suggested by Mark Bates at http://metabates.com/2011/02/07/building-interfaces-and-abstract-classes-in-ruby/.
It didn't seem like this had been turned into a gem yet, so I thought I might go ahead and put it together in case others found the technique as helpful as I had.}
  gem.summary       = %q{Specify interface contracts for your Ruby classes.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "contractual"
  gem.require_paths = ["lib"]
  gem.version       = Contractual::VERSION
end
