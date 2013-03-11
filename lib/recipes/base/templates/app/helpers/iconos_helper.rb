module IconosHelper

  ALIAS = {
    edit: :pencil,
    ver: :search,
    ordenar: :reorder,
    destacado: :heart,
    destroy: :trash
  }

  def icono(nombre, style = :large)
    nombre = nombre.to_s.to_sym
    nombre = ALIAS.fetch(nombre, nombre)

    content_tag :i, '', :class => ["icon-#{nombre}", "icon-#{style}"]
  end

end