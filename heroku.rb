@url_name = ask('Escriba la URL del sitio para Heroku:')

git :init
git :add => '.'
git :commit => "-am 'Commit inicial'"

run "heroku create #{@app_name}"

git :push => 'heroku master'

# Descomentar las lineas que crea necesarias.
run "heroku sharing:add xavier.perera@xaver.com.ar"
run "heroku sharing:add gustavo.molinari@xaver.com.ar"
run "heroku sharing:transfer xavier.perera@xaver.com.ar"
# run "heroku sharing:add sebastian.demichelis@xaver.com.ar"
# run "heroku sharing:add nicanor.perera@xaver.com.ar"

run "heroku addons:add deployhooks:http --url=http://admin.xaver.com.ar/pusheadas"

run 'heroku addons:add pgbackups:auto-week'

run "heroku domains:add www.#{@url_name}"
run "heroku domains:add #{@url_name}"

run 'heroku addons:add sendgrid:starter'
run 'heroku addons:add memcache:5mb'
