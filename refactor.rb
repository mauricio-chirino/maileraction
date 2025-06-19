Dir.glob("app/controllers/api/**/*.rb").each do |file|
  text = File.read(file)
  new_text = text.gsub("ActionController", "ApplicationController")
  File.write(file, new_text)
end
