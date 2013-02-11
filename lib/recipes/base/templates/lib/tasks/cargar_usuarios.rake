# -*- encoding : utf-8 -*-
namespace :cargar do
  task :usuarios => :environment do

    Usuario.create! [
      {
        :rol => :superadmin,
        :username => "gustavo.molinari",
        :email => "gustavo.molinari@xaver.com.ar",
        :password => "123456",
        :password_confirmation => "123456"
      },
      {
        :rol => :superadmin,
        :username => "xavier.perera",
        :email => "xavier.perera@xaver.com.ar",
        :password => "123456",
        :password_confirmation => "123456"
      }
    ]

  end
end