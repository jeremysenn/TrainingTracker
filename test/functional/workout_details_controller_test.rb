require File.dirname(__FILE__) + '/../spec_helper'
 
describe WorkoutDetailsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => WorkoutDetail.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    WorkoutDetail.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    WorkoutDetail.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(workout_detail_url(assigns[:workout_detail]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => WorkoutDetail.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    WorkoutDetail.any_instance.stubs(:valid?).returns(false)
    put :update, :id => WorkoutDetail.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    WorkoutDetail.any_instance.stubs(:valid?).returns(true)
    put :update, :id => WorkoutDetail.first
    response.should redirect_to(workout_detail_url(assigns[:workout_detail]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    workout_detail = WorkoutDetail.first
    delete :destroy, :id => workout_detail
    response.should redirect_to(workout_details_url)
    WorkoutDetail.exists?(workout_detail.id).should be_false
  end
end
