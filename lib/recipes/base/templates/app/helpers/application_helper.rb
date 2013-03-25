# -*- encoding : utf-8 -*-
module ApplicationHelper

  def image_mapa_tag(elemento, tamano = "500x300", zoom = "16")
    url = Addressable::URI.parse "http://maps.google.com/maps/api/staticmap"
    url.query_values = {
      center: elemento.localizacion,
      zoom: zoom,
      size: tamano,
      markers: elemento.localizacion,
      sensor: false
    }

    image_tag url.to_s, :alt => elemento.localizacion, :title => elemento.direccion, :class => "img-polaroid"
  end

  def fecha(una_fecha, opciones = {})
    una_fecha.present? ? l(una_fecha, opciones) : "-"
  end

  def analytics(codigo)
    render 'analytics', :codigo => codigo if codigo.present? && Rails.env.production?
  end

end
