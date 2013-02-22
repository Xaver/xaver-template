# -*- encoding : utf-8 -*-

##############################################################################
#### CONFIGURACIÓN
##############################################################################

RAIZ = File.expand_path(File.join(File.dirname(__FILE__)))

# Carga de recipes
@recipes = {
  :base      => File.join(RAIZ, 'recipes', 'base', 'base.rb'),
  :heroku    => File.join(RAIZ, 'recipes', 'heroku', 'heroku.rb'),
  :consultas => File.join(RAIZ, 'recipes', 'consultas', 'consultas.rb'),
  :archivos  => File.join(RAIZ, 'recipes', 'archivos', 'archivos.rb'),
  :usuarios  => File.join(RAIZ, 'recipes', 'usuarios', 'usuarios.rb')
}

@configuracion = {
  :consultas => yes?("Habrá consultas en la aplicación? (y/n)"),
  :archivos => yes?("Habrá archivos en la aplicación? (y/n)")
}

@fecha ||= Time.now

def aplicar(template)
  apply @recipes[template]
end

def fecha
  @fecha += 1
  @fecha.utc.strftime("%Y%m%d%H%M%S")
end

##############################################################################
#### ARCHIVOS
##############################################################################

puts "-------------------------------------------------------
Removiendo archivos...
-------------------------------------------------------"

remove_file "Gemfile"
remove_file "README"
remove_file "vendor"
remove_file "public/index.html"
remove_file "public/favicon.ico"

remove_file "app/assets/images/rails.png"
remove_file "app/helpers/application_helper.rb"
remove_file "app/assets/stylesheets/application.css"
remove_file "app/assets/javascripts/application.js"
remove_file "app/views/layouts/application.html.erb"
remove_file "app/controllers/application_controller.rb"

remove_file "config/database.yml"
remove_file "config/locales/en.yml"

remove_file "config/environments/production.rb"
remove_file "config/environments/test.rb"
remove_file "config/initializers/inflections.rb"
remove_file "config/application.rb"
remove_file "config/routes.rb"

##############################################################################
#### APLICACIÓN
##############################################################################

puts "-------------------------------------------------------
Configurando aplicación y modelos...
-------------------------------------------------------"

aplicar :base

##############################################################################
#### GEMFILE
##############################################################################

puts "-------------------------------------------------------
Actualizando gemas...
-------------------------------------------------------"

run 'bundle update'

##############################################################################
#### BASE DE DATOS: CREACIÓN
##############################################################################

puts "-------------------------------------------------------
Creando la base de datos...
-------------------------------------------------------"

rake 'db:create'

##############################################################################
#### GENERATORS
##############################################################################

puts "-------------------------------------------------------
Ejecutando generadores...
-------------------------------------------------------"

generate "simple_form:install --bootstrap"
comment_lines 'config/initializers/simple_form.rb', /config.browser_validations = false/

generate "sorcery:install remember_me --model Usuario"
remove_file File.join("..", @app_name, "app", "models", "usuario.rb")
run "rm db/migrate/*sorcery_core*"
gsub_file "config/initializers/sorcery.rb", "# user.username_attribute_names =", "user.username_attribute_names = [:username, :email]"

generate "squeel:initializer"
uncomment_lines 'config/initializers/squeel.rb', /config.load_core_extensions :hash, :symbol/

generate "kaminari:config"

##############################################################################
#### MODELOS
##############################################################################

puts "-------------------------------------------------------
Configurando recursos...
-------------------------------------------------------"

aplicar :usuarios
aplicar :consultas if @configuracion[:consultas]
aplicar :archivos if @configuracion[:archivos]

##############################################################################
#### BASE DE DATOS: MIGRACIÓN Y POPULACIÓN
##############################################################################

puts "-------------------------------------------------------
Migrando y populando la base de datos...
-------------------------------------------------------"

rake 'db:migrate'
rake 'cargar:usuarios'

##############################################################################
#### HEROKU
##############################################################################

puts "-------------------------------------------------------
Configurando Heroku...
-------------------------------------------------------"

aplicar :heroku if yes? 'Desea subir aplicacion a Heroku? (y/n)'
