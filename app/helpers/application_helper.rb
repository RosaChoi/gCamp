module ApplicationHelper
  def filter_params(filter)
    return_hash = {
      description: params[:description]
    }
    
  end
end
