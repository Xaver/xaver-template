# -*- encoding : utf-8 -*-
class VideosController < ApplicationController
  load_resource

  def show
    width = params[:width].presence || 550
    height = params[:height].presence || 450
    render :inline => view_context.video_tag(@video.codigo, width, height)
  end

end