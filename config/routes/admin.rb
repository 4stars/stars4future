Stars4future::Application.routes.draw do
  devise_for :admins
             :path => 'admin',
             :controllers => {
               :sessions => "admin/sessions" },             
             :path_names => {
               :sign_in => 'login',
               :sign_out => 'logout'}  

end
