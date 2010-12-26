class BarController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def add
  end
end
