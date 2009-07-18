module UsersHelper

  def url_params( alert )
    items = { :client_id => alert.client_id, :expanded_project_id => alert.project.id }
    items.merge!( :closed => true ) if alert.project.closed_date
    items
  end

end
