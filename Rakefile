
task :yard do
  puts %x{ yardoc --protected ./lib/**/*.rb }
end

task :rspec do
  puts %x{ rspec }
end

task :pages do
  puts %x{ git checkout gh-pages && git merge master && git push && git checkout master }
end

task :finish => [ :rspec, :yard ]
