require File.dirname(__FILE__) + '/../spec_helper'
 
describe ExerciseTemplatesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => ExerciseTemplate.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    ExerciseTemplate.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ExerciseTemplate.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(exercise_template_url(assigns[:exercise_template]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => ExerciseTemplate.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    ExerciseTemplate.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ExerciseTemplate.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ExerciseTemplate.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ExerciseTemplate.first
    response.should redirect_to(exercise_template_url(assigns[:exercise_template]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    exercise_template = ExerciseTemplate.first
    delete :destroy, :id => exercise_template
    response.should redirect_to(exercise_templates_url)
    ExerciseTemplate.exists?(exercise_template.id).should be_false
  end
end
