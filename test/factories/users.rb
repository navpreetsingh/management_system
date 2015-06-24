FactoryGirl.define do
  factory :user do
  	factory :admin_user do
	    username "admin"
	    email "admin@admin.com"
	    ecode 1
	    gender_id 1
	    role :admin
	    card_no 1
	end

	factory :manager_user do 
		username "manager"
	    email "manager@admin.com"
	    ecode 1
	    gender_id 1
	    role :manager
	    card_no 2
	end

  end
end