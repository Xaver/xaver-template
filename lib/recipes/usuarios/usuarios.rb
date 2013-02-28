@directorio = File.join(File.dirname(__FILE__), 'templates')

puts "\nConfigurando usuarios..."
directory @directorio, File.join("..", @app_name)

insert_into_file "app/views/admin/admin/_nav_lateral.html.erb", "\n    <li><%= link_to 'Usuarios', admin_usuarios_path if can? :index, Usuario %></li>", :after => '<li class="nav-header">General</li>'

insert_into_file "config/routes.rb", :after => "namespace :admin do" do
  "\n    resources :usuarios, :except => :show"
end