RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.authorize_with :cancan
  # config.current_user_method(&:current_user)
  ## == Cancan ==
  

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.excluded_models << "UserAttendance"

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end


  config.navigation_static_links = {
    'Reports' => '/admin/reports',
    'Loss Of Pay Data' => '/admin/reports/loss_of_pays',
    'Assign leaves to employees' => "/admin/leaves/",
    'Import Users' => "/admin/users/import",
    'Export Users' => '/admin/users/export'
  }
  #config.navigation_static_label = "Reports"
end
