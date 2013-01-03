# -*- encoding : utf-8 -*-
class Archivo < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  attr_accessible :titulo, :archivo, :remove_archivo

  before_create :set_atributos_ocultos

  belongs_to :propietario, :polymorphic => true, :touch => true

  image_accessor :archivo do
    storage_path { |f| File.join carpeta, "#{id}-#{rand(10000)}.#{f.format}" }
  end

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  default_scope -> { order{orden} }

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def carpeta
    File.join propietario.carpeta, 'archivos'
  end

  def se_puede_eliminar?
    true
  end

  def destroy
    super if se_puede_eliminar?
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################

  alias_attribute :to_label, :titulo
  alias_attribute :to_s, :titulo

  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def set_atributos_ocultos
    if archivo.present?
      self.width = archivo.width 
      self.height = archivo.height
      self.peso = archivo.size
      self.mime_type = archivo.mime_type
      self.format = archivo.format
    end
  end

end
