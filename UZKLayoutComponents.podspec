Pod::Spec.new do |s|
  s.name     = 'UZKLayoutComponents'
  s.version  = '1.0.2'
  s.license  = 'MIT'
  s.summary  = 'Foobar'
  s.authors  = { 'Tiago Furlanetto' => 'tiago.f.furlanetto@gmail.com' }
  s.source   = { :git => 'https://Uzaak@bitbucket.org/Uzaak/uzklayoutcomponents.git' }
  s.source_files = 'PodContent/*.{h,m}'
  s.resources = 'PodContent/*.xib'
  s.requires_arc = true
  s.homepage = 'http://www.google.com'
end
