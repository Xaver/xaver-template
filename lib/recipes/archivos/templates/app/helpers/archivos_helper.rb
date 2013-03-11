# -*- encoding : utf-8 -*-
module ArchivosHelper

  def video_youtube_url(codigo)
    return File.join 'http://www.youtube.com', 'embed', codigo
  end

  def video_tag(codigo, width, height)
    width = 550 if width.to_i.zero?
    height = 450 if height.to_i.zero?
    content_tag :iframe, nil, :width => width, :height => height, :src => video_youtube_url(codigo), :frameborder => 0, :allowfullscreen => true
  end

end