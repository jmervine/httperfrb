task :yard do
  puts %x{ yardoc --protected ./lib/**/*.rb }
end

task :rspec do
  puts %x{ rspec -f d -c | tee rspec.tmp }
  %x{ cat rspec.tmp | sed -e 's/^/\t\t/g' > RSPECOUT.md && rm rspec.tmp }
end

task :pages do
  puts %x{ git checkout gh-pages && git merge master && git push && git checkout master }
end

task :finish => [ :rspec, :yard ]
