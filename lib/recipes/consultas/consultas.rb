@directorio = File.join(File.dirname(__FILE__), 'templates')

puts "\nConfigurando consultas..."
directory @directorio, File.join("..", @app_name)

insert_into_file "app/views/admin/admin/_nav_lateral.html.erb", "\n    <li><%= nav_li Consulta %></li>", :after => '<li class="nav-header">General</li>'

insert_into_file "config/routes.rb", :after => "namespace :admin do" do
  "\n    resources :consultas, :only => [:index, :show, :destroy]"
end

insert_into_file "config/routes.rb", :before => "root :to => 'application#index'" do
  "resources :consultas, :only => :create
  match :contacto, :to => 'consultas#new'"
end