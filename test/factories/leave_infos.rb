FactoryGirl.define do
	factory :leave_info do
		factory :approved_leave do
			user_id 1
			date_from 25.days.ago
			date_to 23.days.ago
			reason "Busy"
			leave_applied_date 30.days.ago
			leave_approved_date 27.days.ago
			approved 1
			rejected 0
			cancelled 0
			cancel_request 0
		end

		factory :rejected_leave do
			user_id 1
			date_from 35.days.ago
			date_to 33.days.ago
			reason "Busy"
			leave_applied_date 40.days.ago
			leave_approved_date 37.days.ago
			approved 0
			rejected 1
			cancelled 0
			cancel_request 0
		end

		factory :cancelled_leave do
			user_id 1
			date_from 45.days.ago
			date_to 43.days.ago
			reason "Busy"
			leave_applied_date 50.days.ago
			leave_approved_date 47.days.ago
			approved 0
			rejected 0
			cancelled 1
			cancel_request 1
		end



	end
end