# -*- encoding : utf-8 -*-
namespace :cargar do
  
  task :reset => :environment do
    invocar "matar:postgres"
    db :drop
    db :create
    db :migrate
    db :seed
  end
     
  task :todo => :environment do
    puts 'Cargando...'
    cargar :usuarios
    puts 'Listo!'
  end
    
  def cargar(nombre)
    invocar "cargar:#{nombre}"
  end
  
  def db(nombre)
    invocar "db:#{nombre}"
  end
  
  def invocar(tarea)
    puts tarea.to_s.upcase
    Rake::Task[tarea].invoke
  end
end
