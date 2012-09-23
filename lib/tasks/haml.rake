namespace :erb do
  namespace :to do
  	desc "convert all .html.erb files to .html.haml"
    task :haml do
      files = `find . -iname *.erb`
      files.each_line do |file|
        file.strip!
        `bundle exec html2haml #{file} | cat > #{file.gsub(/\.erb$/,".haml")}`        
        `rm #{file}`
      end
    end
  end
end