ActiveAdmin.register_page "Stats" do
  controller do
  end
  content do
    render partial: 'reportall'
  end
  #member_action :indivi do
    #@indivi = resource.reportindiv
    # This will render app/views/admin/posts/comments.html.erb
  #end  
end