# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "SpaceInvaders"
  spec.version       = '1.0'
  spec.authors       = ["JuliaEidelwein","LauraSoares","LeonardoRodrigues"]
  spec.email         = ["jeidelwein@inf.ufrgs.br","lrsoares@inf.ufrgs.br","lmrodrigues@inf.ufrgs.br"]
  spec.summary       = %q{Remake os the classical Space Invaders game}
  spec.description   = %q{Space Invaders implemented using functional programming as an assingment for the course Pragramming Languages Models, at inf-UFRGS}
  spec.homepage      = "https://github.com/JuliaEidelwein/Space_invaders-balao_magico"
  spec.license       = "UFRGS"

  spec.files         = ['lib/SpaceInvaders.rb']
  spec.executables   = ['bin/SpaceInvaders']
  spec.test_files    = ['tests/test_SpaceInvaders.rb']
  spec.require_paths = ["lib"]
end