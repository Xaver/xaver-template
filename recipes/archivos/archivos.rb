@directorio = File.join(File.dirname(__FILE__), 'templates')

puts "\nConfigurando archivos..."
directory @directorio, File.join("..", @app_name)

insert_into_file "config/routes.rb", :before => "root :to => 'application#index'" do
  "\nresources :fotos, :adjuntos, :videos, :only => :show\n"
end

insert_into_file "config/routes.rb", :after => "namespace :admin do" do
  "\nconcern :archivable do
      resources :archivos, :only => :index do
        post :crear, :on => :collection
        get :editar, :on => :collection
        post :actualizar, :on => :collection
      end
      resources :fotos, :adjuntos, :videos do
        post :reordenar, :on => :collection
      end
    end

    resources :archivos, :only => :destroy\n"
end

