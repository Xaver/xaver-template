@directorio = File.join(File.dirname(__FILE__), 'templates')

puts "\nConfigurando usuarios..."
directory @directorio, File.join("..", @app_name)