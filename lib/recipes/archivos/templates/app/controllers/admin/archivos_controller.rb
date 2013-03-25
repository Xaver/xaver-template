# -*- encoding : utf-8 -*-
class Admin::ArchivosController < Admin::AdminController
  include Ordenable
  # Cargar los propietarios
  # load_resource <<propietario>>, :instance_name => :propietario
  load_and_authorize_resource :through => :propietario, :shallow => true
  load_and_authorize_resource :through => :propietario, :through_association => :fotos, :shallow => true, :instance_name => :fotos
  load_and_authorize_resource :through => :propietario, :through_association => :adjuntos, :shallow => true, :instance_name => :adjuntos
  load_and_authorize_resource :through => :propietario, :through_association => :videos, :shallow => true, :instance_name => :videos

  def index
  end

  def edit
  end

  def update
    @archivo.update_attributes! params[:archivo]
    redirect_to edit_admin_archivo_path(@archivo), notice: mensaje
  end

  def crear
    begin
      @propietario.update_attributes! params[:propietario]
      redirect_to polymorphic_path([:admin, @propietario, :archivos], :anchor => params[:anchor]), notice: mensaje
    rescue
      redirect_to polymorphic_path([:admin, @propietario, :archivos], :anchor => params[:anchor]), alert: mensaje(:alert)
    end
  end

  def editar
    redirect_to [:admin, @propietario, :archivos], notice: notice if @archivos.empty?
  end

  def actualizar
    @propietario.archivos.update params[:propietario][:elementos].keys, params[:propietario][:elementos].values
    redirect_to [:editar, :admin, @propietario, :archivos], notice: mensaje
  end

  def destroy
    @archivo.destroy
    mensaje
  end

end