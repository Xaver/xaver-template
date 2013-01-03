# -*- encoding : utf-8 -*-
class FotosController < ApplicationController
  load_resource

  def show
    tamano = case params[:size]
    when 'small' then 'x150'
    when 'medium' then 'x350'
    when 'large' then 'x550'
    end
    tamano = params[:scale] if params[:scale].present?

    # Si el parámetro :scale no cumple la siguiente expresión, ^\d{0,3}x\d{0,3}$ se dispara la excepción.

    begin
      archivo = @foto.archivo.thumb(tamano) if tamano.present?
      archivo ||= @foto.archivo
      send_data archivo.file.read, :type => @foto.mime_type, :disposition => 'inline'
    rescue
      redirect_to foto_path(@foto, :size => :large)
    end
  end

end