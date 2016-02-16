class Quote < ActiveRecord::Base
  
  private
  
  def quote_params
    params.require(:quote).permit(:text)
  end
  
end
