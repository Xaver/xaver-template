module FormHelper

  include MiniForm

  def nombre_tabla(clase)
    clase.name.tableize
  end

  # Retorna el header de la tabla. 
  def thead(*args)
    content_tag :thead, content_tag(:tr, args.map { |arg| content_tag :th, arg.to_s.humanize }.join.html_safe)
  end

  def id_for(elemento)
    "elementos_#{elemento.to_param}"
  end

end