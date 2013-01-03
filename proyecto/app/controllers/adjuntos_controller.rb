# -*- encoding : utf-8 -*-
class AdjuntosController < ApplicationController
  load_resource

  def show
    send_data(@adjunto.archivo.file.read, :filename => @adjunto.archivo_name, :type => @adjunto.archivo.mime_type)
  end

end