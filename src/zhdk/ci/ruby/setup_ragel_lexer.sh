VERSION=$1
rbenv shell $VERSION 
gem install gherkin -v 2.12.0
cd ~/.rbenv/versions/$VERSION/lib/ruby/gems/1.9.1/gems/gherkin-2.12.0/ 
bundle install
rbenv rehash
bundle exec rake compile:gherkin_lexer_en
