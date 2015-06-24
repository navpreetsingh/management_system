FactoryGirl.define do
	factory :leave_credit do

		factory :approved_credit do
			user_id 1
			leave_id 1
			attendance_id 25
			leave_info_id 1
			leave_credited_date 25.days.ago
			consumed 1
		end

		factory :rejected_credit do
			user_id 1
			leave_id 2
			attendance_id 35
			leave_info_id 2
			leave_credited_date 35.days.ago
			consumed 1
		end

		factory :cancelled_credit do
			user_id 1
			leave_id 2
			attendance_id 45
			leave_info_id 3
			leave_credited_date 35.days.ago
			consumed 0
		end
	end
end