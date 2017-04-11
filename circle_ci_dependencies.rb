cache_directories = %w{
  deps/apt
  deps/sources
}

# create directories if they don't exist
cache_directories.each do |dir|
  `mkdir -p #{dir}` unless File.directory?(dir)
end


chrome_version = (`google-chrome --version`).match(/[\d\.]+$/)[0]
puts "Google Chrome Version: #{chrome_version}"
if Gem::Version.new(chrome_version) > Gem::Version.new("57.0.0")
  puts "We need to update Google Chrome"
  `wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -`
  `sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'`
  `sudo apt-get update`
  `sudo apt-get --only-upgrade install google-chrome-stable`
  puts `google-chrome --version`
else
  puts "No need to update Google Chrome"
end

