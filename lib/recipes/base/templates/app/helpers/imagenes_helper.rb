module ImagenesHelper

  def imagen(imagen, tamano, opciones = nil, html_options = {})
    if imagen.present?
      image_tag imagen_path(imagen, tamano, opciones), html_options
    else
      html_options[:data] ||= {}
      html_options[:data][:src] = holder_path(tamano)
      image_tag 'default.png', html_options
    end
  end

  def imagen_path(imagen, tamano, opciones = nil)
    imagen.thumb(tamano + opciones.to_s).url if imagen.present?
  end

  def holder_path(tamano, texto = nil)
    holder = "holder.js/#{tamano}"
    holder += "/text:#{texto}" if texto.present?
    return holder
  end

  def rgba(hexadecimal, opacidad)
    rgb = hexadecimal.match /#(..)(..)(..)/
    r = rgb[1].hex
    g = rgb[2].hex
    b = rgb[3].hex
    return "rgba(#{r}, #{g}, #{b}, #{opacidad})"
  end

end