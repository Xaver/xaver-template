# -*- encoding : utf-8 -*-
class Admin::VideosController < Admin::ArchivosController

  private

  def sort_coleccion
    @propietario.videos
  end

end