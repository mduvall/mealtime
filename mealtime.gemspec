Gem::Specification.new do |s|
  s.name          = 'mealtime'
  s.version       = '0.0.1'
  s.date          = '2012-05-11'
  s.summary       = "mealtime: A gem for lunch"
  s.description   = "Finding that tasty lunchtime spot"
  s.authors       = ["Matthew DuVall"]
  s.email         = 'mduvall89@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.require_path  = 'lib'
  s.homepage      = 'http://www.mattduvall.com'
  s.executables   << "mealtime"
end