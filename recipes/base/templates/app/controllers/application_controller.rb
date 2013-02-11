# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include Excepciones
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid,  with: :record_invalid
  rescue_from CanCan::AccessDenied,         with: :access_denied

  before_filter :set_variables
  helper_method :ubicar, :variables

  def index
    set_variables 'Sitio en construcción'
    render :layout => false
  end

  def error_404
    set_variables 'Error 404'
    render :layout => false
  end

  def ubicar
    if logged_in?
      case current_user.try(:rol)
      when 'superadmin'
        admin_usuarios_path
      when 'admin'
        admin_usuarios_path
      else
        root_path
      end
    else
      root_path
    end
  end

  def variables
    @variables || {}
  end

  def set_variables(title = nil, description = nil, keywords = nil)
    @variables = { title: title, description: description, keywords: keywords }
  end

  private

  def mensaje(clave = :notice, valor = action_name)
    msj = t("#{clave}.#{valor}")
    case clave
    when :notice
      flash.now.notice = msj
    when :alert
      flash.now.alert = msj
    end
  end

end