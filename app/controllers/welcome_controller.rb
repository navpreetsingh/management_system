class WelcomeController < ApplicationController
  def dummy_database
  	FactoryGirl.create :male
    FactoryGirl.create :female
    FactoryGirl.create :sick_leave
    FactoryGirl.create :casual_leave
    FactoryGirl.create :admin_user
    FactoryGirl.create :manager_user
    10.times { FactoryGirl.create :present }
    50.times { FactoryGirl.create :absent }
    FactoryGirl.create :approved_leave
    FactoryGirl.create :rejected_leave
    FactoryGirl.create :cancelled_leave
    FactoryGirl.create :approved_credit
    FactoryGirl.create :rejected_credit
    FactoryGirl.create :cancelled_credit
    redirect_to :root
  end
end
