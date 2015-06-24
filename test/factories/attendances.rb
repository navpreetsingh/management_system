FactoryGirl.define do
	sequence :attendance_date do |n|
		n.days.ago
	end

	factory :attendance do 

		factory :present do
			user_id 1
			attendance_date 
			present 1
		end

		factory :absent do
			user_id 1
			attendance_date 
			present 0
		end

	end
end