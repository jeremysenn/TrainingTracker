require File.dirname(__FILE__) + '/../spec_helper'

describe GymsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Gym.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Gym.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Gym.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(gym_url(assigns[:gym]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Gym.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Gym.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Gym.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Gym.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Gym.first
    response.should redirect_to(gym_url(assigns[:gym]))
  end

  it "destroy action should destroy model and redirect to index action" do
    gym = Gym.first
    delete :destroy, :id => gym
    response.should redirect_to(gyms_url)
    Gym.exists?(gym.id).should be_false
  end
end
