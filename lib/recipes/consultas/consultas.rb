@directorio = File.join(File.dirname(__FILE__), 'templates')

puts "\nConfigurando consultas..."
directory @directorio, File.join("..", @app_name)

insert_into_file "app/views/admin/admin/_nav_lateral.html.erb", "\n<li><%= link_to 'Consultas', admin_consultas_path if can? :index, Consulta %></li>", :after => '<li class="nav-header">General</li>'

insert_into_file "config/routes.rb", :after => "namespace :admin do" do
  "\nresources :consultas, :only => [:index, :show, :destroy]\n"
end

insert_into_file "config/routes.rb", :before => "root :to => 'application#index'" do
  "\nresources :consultas, :only => :create
   match :contacto, :to => 'consultas#new'\n"
end