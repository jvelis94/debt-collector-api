require 'rails_helper'

RSpec.describe "Bills", type: :request do
  let!(:user) { create :user }
  
  describe "create bills" do
    it 'should create new bill' do
      expect do 
        post '/api/bills', params: { bill: { bill_name: "Chipotle Trip", user_id: user.id }, format: :json }
      end.to change(Bill, :count).by(1)
    end
  end
end
