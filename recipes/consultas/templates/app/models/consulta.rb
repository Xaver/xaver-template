# -*- encoding : utf-8 -*-
class Consulta < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  attr_accessible :nombre, :apellido, :telefono, :email, :direccion, :localidad, :mensaje

  after_create :enviar

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  default_scope -> { order{created_at.desc} }

  validates :nombre, :email, :mensaje, :presence => true

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def nombre_completo
    [nombre, apellido].join(" ")
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

  alias_attribute :to_label, :nombre_completo
  alias_attribute :to_s, :nombre_completo

  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def enviar
    Notificador.consulta(self).deliver
  end

end
