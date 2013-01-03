# -*- encoding : utf-8 -*-
class Notificador < ActionMailer::Base
  helper :application
  default css: :email, from: "Nombre Sitio <robot@xaver.com.ar>"

  def consulta(consulta)
    @consulta = consulta
    para = 'info@xaver.com.ar'
    asunto = 'Nueva consulta!'
    mail to: para, subject: asunto, reply_to: @consulta.email.to_s
  end

end
