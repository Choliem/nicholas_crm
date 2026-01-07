class StaticPagesController < ApplicationController
  before_action :authorized, only: [:dashboard] 

  def home
  end

  def dashboard
  end
end