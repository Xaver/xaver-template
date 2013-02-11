# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  ROLES = 'superadmin', 'admin'

  authenticates_with_sorcery!

  attr_accessor :login
  attr_accessible :login, :username, :email, :password, :password_confirmation, :rol

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  default_scope -> { order{username} }

  validates :password, :confirmation => true
  validates :password, :presence => true, :on => :create
  validates :username, :email, :presence => true, :uniqueness => true
  validates :rol, :presence => true

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def rol_es?(un_rol)
    rol == un_rol.to_s
  end

  def roles_que_puede_crear
    case rol.to_sym
    when :superadmin
      ROLES
    when :admin
      ROLES - [:superadmin]
    end
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

  alias_attribute :to_label, :username
  alias_attribute :to_s, :username

  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

end
