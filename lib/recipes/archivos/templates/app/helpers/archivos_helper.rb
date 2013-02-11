# -*- encoding : utf-8 -*-
module ArchivosHelper

  def imagen(imagen, tamano, opciones = nil, html_options = {})
    clases = html_options[:class]
    html_options.merge! :class => [clases, :placeholder] if imagen.nil?
    image_tag imagen_path(imagen, tamano, opciones), html_options
  end

  def imagen_path(imagen, tamano, opciones = nil)
    imagen.present? ? imagen.thumb(tamano + opciones.to_s).url : asset_path("default-#{tamano}.png")
  end

  def icono(nombre, style = :large)
    nombres = { edit: :pencil, ver: :search, ordenar: :reorder, destacado: :heart, destroy: :trash }
    nombre = nombres[nombre.to_sym] if nombres.include? nombre.to_sym

    content_tag :i, '', :class => ["icon-#{nombre}", "icon-#{style}"]
  end

  def video_youtube_url(codigo)
    return File.join 'http://', 'www.youtube.com', 'embed', codigo
  end

  def video_tag(codigo, width, height)
    width = 550 if width.to_i.zero?
    height = 450 if height.to_i.zero?
    content_tag :iframe, nil, :width => width, :height => height, :src => video_youtube_url(codigo), :frameborder => 0, :allowfullscreen => true
  end

end
