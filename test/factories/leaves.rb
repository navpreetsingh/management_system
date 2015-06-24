FactoryGirl.define do
	factory :leave do 
	
		factory :sick_leave do
			name "Sick Leave"
		end
		
		factory :casual_leave do 
			name "Casual Leave"
		end

		factory :earned_leave do 
			name "Earned Leave"
		end

		factory :compensatory_leave do 
			name "Compensatory Leave"
		end
		
	end
end