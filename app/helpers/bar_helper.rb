module BarHelper
  def easyXDM
    if Rails.env == "staging" or Rails.env == "development"
      'easyXDM.debug.js'
    else
      'easyXDM.min.js'
    end
  end
end
