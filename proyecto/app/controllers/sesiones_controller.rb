# -*- encoding : utf-8 -*-
class SesionesController < ApplicationController
  layout 'admin'

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new params[:usuario]
    login @usuario.email, @usuario.password
    if logged_in?
      redirect_to ubicar, notice: mensaje(:notice, :sesion_iniciada)
    else
      mensaje(:alert, :sesion_no_iniciada)
      render :new
    end
  end

  def destroy
    logout
    redirect_to ubicar, notice: notice, alert: alert
  end

end