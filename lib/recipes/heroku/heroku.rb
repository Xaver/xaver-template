@url_name = ask('Escriba la URL del sitio para Heroku:')

git :init
git :add => '.'
git :commit => "-am 'Commit inicial'"

append_file ".gitignore", ""
append_file ".gitignore", "config/database.yml"
append_file ".gitignore", "nbproject/*"
append_file ".gitignore", "tmp/*"
append_file ".gitignore", "log/*"
append_file ".gitignore", "log/*.log"

run "heroku create #{@app_name}"

# Descomentar las lineas que crea necesarias.
run "heroku sharing:add xavier.perera@xaver.com.ar"
run "heroku sharing:add gustavo.molinari@xaver.com.ar"
run "heroku sharing:transfer xavier.perera@xaver.com.ar"

run "heroku addons:add deployhooks:http --url=http://admin.xaver.com.ar/pusheadas"

run 'heroku addons:add pgbackups:auto-week'

run "heroku domains:add www.#{@url_name}"
run "heroku domains:add #{@url_name}"

run 'heroku addons:add sendgrid:starter'
run 'heroku addons:add memcache:5mb'

run 'heroku labs:enable user-env-compile'

git :push => 'heroku master'