# -*- encoding : utf-8 -*-
class Admin::AdminController < ApplicationController
  before_filter :require_login
  layout "admin"
  helper_method :admin_polymorphic_path, :new_admin_polymorphic_path, :edit_admin_polymorphic_path

  def index
    redirect_to ubicar, notice: notice, alert: alert
  end

end