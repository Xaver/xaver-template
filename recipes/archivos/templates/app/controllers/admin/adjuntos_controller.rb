# -*- encoding : utf-8 -*-
class Admin::AdjuntosController < Admin::ArchivosController

  private

  def sort_coleccion
    @propietario.adjuntos
  end

end