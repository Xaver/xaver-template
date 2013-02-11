# -*- encoding : utf-8 -*-
class Admin::FotosController < Admin::ArchivosController

  private

  def sort_coleccion
    @propietario.fotos
  end

end