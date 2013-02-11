# -*- encoding : utf-8 -*-
class Admin::ConsultasController < Admin::AdminController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def destroy
    @consulta.destroy
    mensaje
  end

end