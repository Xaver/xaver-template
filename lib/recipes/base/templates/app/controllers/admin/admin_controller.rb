# -*- encoding : utf-8 -*-
class Admin::AdminController < ApplicationController
  before_filter :require_login
  layout "admin"

  def index
    redirect_to ubicar, notice: notice, alert: alert
  end

end