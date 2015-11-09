require 'rails_helper'

RSpec.describe ContributionsController, type: :controller do
  before do
    make_user_group_member
    request.headers.merge!(user.create_new_auth_token)
  end

  describe "#create" do
    before do
      bucket.update(target: 100, group: group)
    end

    context "contribution amount does not exceed contributor's balance" do
      before do
        create(:allocation, user: user, group: group, amount: 1000)
      end

      context "contribution amount does not exceed bucket's funding target" do
        before do
          contribution_params = {
            bucket_id: bucket.id,
            amount: 50
          }
          post :create, {contribution: contribution_params}
          @contribution = Contribution.find_by(contribution_params)
        end

        it "returns http status created" do
          expect(response).to have_http_status(:created)
        end

        it "creates contribution for current_user with specified amount" do
          expect(@contribution).to be_truthy
        end

        it "returns the contribution as json" do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response["contributions"][0]["id"]).to eq(@contribution.id)
        end
      end

      context "contribution amount meets bucket's funding target" do
        it "updates bucket status to 'funded'" do
          contribution_params = {
            bucket_id: bucket.id,
            amount: 100
          }
          post :create, {contribution: contribution_params}
          expect(bucket.reload.status).to eq('funded')  
        end
      end

      context "contribution amount exceeds bucket's funding target" do
        it "contribution amount is decreased to exactly meet the bucket's funding target" do
          contribution_params = {
            bucket_id: bucket.id,
            amount: 150
          }
          post :create, {contribution: contribution_params}
          @contribution = Contribution.find_by(bucket: bucket)
          expect(@contribution.amount).to eq(100)
        end
      end
    end

    context "contribution amount exceeds contributor's balance" do
      before do
        create(:allocation, user: user, amount: 10)
        contribution_params = {
          bucket_id: bucket.id,
          amount: 50
        }
        post :create, {contribution: contribution_params}
        @contribution = Contribution.find_by(contribution_params)
      end

      it "returns http status forbidden" do
        expect(response).to have_http_status(:forbidden)
      end

      it "does not create the contribution" do
        expect(@contribution).to be_nil
      end
    end
  end
end
