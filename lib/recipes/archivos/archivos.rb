@directorio = File.join(File.dirname(__FILE__), 'templates')

puts "\nConfigurando archivos..."
directory @directorio, File.join("..", @app_name)

insert_into_file "config/routes.rb", :before => "root :to => 'application#index'" do
  "
  resources :fotos, :adjuntos, :videos, :only => :show

  "
end

insert_into_file "config/routes.rb", :before => "namespace :admin" do
  "concern :archivable do
    resources :archivos, :only => :index do
      post :crear, :on => :collection
      get :editar, :on => :collection
      post :actualizar, :on => :collection
    end
    resources :fotos, :adjuntos, :videos, :concerns => :ordenable
  end

  resources :archivos, :only => :destroy

  "
end

