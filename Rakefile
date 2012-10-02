task :yard do
  puts %x{ yardoc --protected ./lib/**/*.rb }
end

task :rspec do
  puts %x{ rspec -f d -c | tee rspec.tmp }
  %x{ cat rspec.tmp | sed -e 's/^/\t\t/g' > RSPECOUT.md && rm rspec.tmp }
end

desc "generate and update gh-pages"
task :pages do
  system(" set -x; bundle exec rspec ") or abort
  system(" set -x; bundle exec yardoc --protected ./lib/**/*.rb ") or abort
  system(" set -x; rm -rf /tmp/doc /tmp/coverage ") or abort
  system(" set -x; mv -v ./doc /tmp ") or abort
  system(" set -x; mv -v ./coverage /tmp ") or abort
  system(" set -x; git checkout gh-pages ") or abort
  system(" set -x; rm -rf ./doc ./coverage ") or abort
  system(" set -x; mv -v /tmp/doc . ") or abort
  system(" set -x; mv -v /tmp/coverage . ") or abort
  system(" set -x; git add . ") or abort 
  system(" set -x; git commit --all -m 'updating doc and coverage' ") or abort
  system(" set -x; git checkout master ") or abort
  puts "don't forget to run: git push origin gh-pages"
end

task :finish => [ :rspec, :yard ]
