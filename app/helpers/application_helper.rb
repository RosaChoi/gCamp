module ApplicationHelper
  def filter_params(filter)
    return_hash = {
      complete: params[:complete],
      order_by_complete: params[:order_by_complete],
      order_by_description: params[:order_by_description],
      order_by_due_date: params[:order_by_due_date],
    }.merge(filter)

    return_hash
  end
end
