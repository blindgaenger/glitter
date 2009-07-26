spec = Gem::Specification.new do |s| 
  s.name = 'glitter'
  s.version = '0.0.1'
  s.author = 'blindgaenger'
  s.email = 'blindgaenger@gmail.com'
  s.homepage = 'http://blindgaenger.github.com/glitter'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Git-Like Interface for Twitter'
# Add your other files here if you make them
  s.files = %w(
bin/glitter
lib/commands/commit.rb
lib/commands/init.rb
lib/commands/log.rb
lib/twitter_app.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','glitter.rdoc']
  s.rdoc_options << '--title' << 'Git Like Interface' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'glitter'
end
