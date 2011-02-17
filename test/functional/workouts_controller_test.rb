require File.dirname(__FILE__) + '/../spec_helper'
 
describe WorkoutsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Workout.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Workout.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Workout.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(workout_url(assigns[:workout]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Workout.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Workout.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Workout.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Workout.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Workout.first
    response.should redirect_to(workout_url(assigns[:workout]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    workout = Workout.first
    delete :destroy, :id => workout
    response.should redirect_to(workouts_url)
    Workout.exists?(workout.id).should be_false
  end
end
