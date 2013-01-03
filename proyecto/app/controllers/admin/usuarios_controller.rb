# -*- encoding : utf-8 -*-
class Admin::UsuariosController < Admin::AdminController
  load_and_authorize_resource :except => [:edit, :update]
  before_filter :get_usuario, :only => [:edit, :update]

  def index
  end

  def new
  end

  def edit
  end

  def create
    @usuario = Usuario.new params[:usuario]
    @usuario.save!
    redirect_to admin_usuarios_path, notice: mensaje
  end

  def update
    @usuario.update_attributes! params[:usuario]
    redirect_to edit_admin_usuario_path(@usuario), notice: mensaje
  end

  def destroy
    @usuario.destroy
    mensaje
  end

  private

  def get_usuario
    if can? :manage, Usuario
      @usuario = Usuario.find params[:id]
    else
      @usuario = current_user
    end
  end

end