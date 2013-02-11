# -*- encoding : utf-8 -*-
module ListadosHelper

  def desplegable(*args)
    render 'desplegable', :botones => args
  end

  def acciones(*args)
    render 'acciones', :botones => args.extract_options!
  end

  def tr_for(elemento, &block)
    content_tag :tr, capture(&block), id: "elementos_#{elemento.to_param}"
  end

  def boton_new(klass)
    link_to icono(:plus) + " Agregar #{klass.name.singularize}", [:new, :admin, klass.name.underscore], :class => 'btn btn-primary btn-large' if can? :create, klass
  end

  def boton_new_desplegable(klass)
    link_to icono(:plus) + content_tag(:span, " Agregar #{klass.name.singularize}"), [:new, :admin, klass.name.underscore], tabindex: -1 if can? :create, klass
  end

  def boton_edicion_masiva(elemento)
    link_to icono(:edit) + ' Edición masiva', [:editar, :admin, elemento, :archivos], :class => 'btn btn-primary btn-large'
  end

  def boton_volver(klass, path = nil)
    link_to icono('arrow-left') + ' Volver', path.presence || [:admin, klass.name.tableize], :class => 'btn btn-primary btn-large'
  end

  def boton_dropdown
    dropdown = link_to 'Acciones', { :anchor => :dropdown }, :class => 'btn btn-primary principal'
    flecha = button_tag content_tag(:span, nil, :class => :caret), :class => 'btn btn-primary dropdown-toggle', :data => { :toggle => :dropdown }
    return dropdown + flecha
  end

  def boton_mover(klass)
    link_to icono(:ordenar) + content_tag(:span, 'Mover'), { anchor: :mover }, :class => 'btn btn-primary handle', title: 'Mantenga click y arrastre para reordenar' if can? :reordenar, klass
  end

  def boton_archivos(elemento, mostrar = true)
    if mostrar
      link_to icono('file') + content_tag(:span, 'Archivos'), [:admin, elemento, :archivos], tabindex: -1
    else
      link_to icono('file') + content_tag(:span, 'Archivos'), { :anchor => :archivos }, :class => :disabled, :title => 'No se pueden agregar archivos'
    end
  end

  def boton_ver(recurso, path = nil)
    link_to icono(:ver) + content_tag(:span, 'Ver'), path.presence || recurso, target: :_blank, tabindex: -1
  end

  def boton_editar(recurso, condicion = true)
    if condicion && can?(:update, recurso)
      link_to icono(:edit) + content_tag(:span, 'Editar'), [:edit, :admin, recurso], tabindex: -1
    else
      link_to icono(:edit) + content_tag(:span, 'Editar'), { :anchor => :editar }, tabindex: -1, :class => :disabled
    end
  end

  def boton_eliminar(recurso, path = nil)
    if recurso.se_puede_eliminar? && can?(:destroy, recurso)
      link_to icono(:destroy) + content_tag(:span, 'Eliminar'), path.presence || [:admin, recurso], method: :delete, remote: true, data: { confirm: t("confirmacion"), disable_with: t("espere") }, tabindex: -1
    else
      link_to icono(:destroy) + content_tag(:span, 'Eliminar'), { :anchor => :eliminar }, tabindex: -1, :class => :disabled, :title => 'No se puede eliminar'
    end
  end

end
