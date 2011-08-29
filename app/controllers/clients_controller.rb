class ClientsController < ApplicationController
  load_and_authorize_resource

  def index
    login_required
    #@clients = Client.all
    @clients = current_user.clients.all.sort_by(&:first_name)#.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    login_required
    @client = Client.find(params[:id])
  end

  def new
    login_required
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])

    ### CHECK TO SEE IF THERE IS A USER IN THE SYSTEM WITH THIS CLIENT'S EMAIL TO CONNECT THE TWO ###
    user_account = User.find_by_email(@client.email)
    unless user_account.blank?
      user_account.client_training_id = @client.id
      user_account.is_client = true
    end

    if @client.save
      user_account.save unless user_account.blank?
      redirect_to @client, :notice => "Successfully created client."
    else
      render :action => 'new'
    end
  end

  def edit
    login_required
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    ### CHECK TO SEE IF THERE IS A USER IN THE SYSTEM WITH THIS CLIENT'S EMAIL TO CONNECT THE TWO ###
    user_account = User.find_by_email(@client.email)
    unless user_account.blank?
      user_account.client_training_id = @client.id
      user_account.is_client = true
    end
    
    if @client.update_attributes(params[:client])
      user_account.save unless user_account.blank?
      redirect_to @client, :notice  => "Successfully updated client."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url, :notice => "Successfully destroyed client."
  end

  def biosig_graphs
    @client = Client.find(params[:id])

    ### GET A COUNT JUST IN CASE ENTRIES ARE NEVER MADE, SO DON'T WANT TO SHOW GRAPH ###
    @chin_count = 0
    @cheek_count = 0
    @pec_count = 0
    @tri_count = 0
    @subscap_count = 0
    @suprailiac_count = 0
    @midaxil_count = 0
    @umbilical_count = 0
    @knee_count = 0
    @calf_count = 0
    @quad_count = 0
    @ham_count = 0
    @waist_count = 0
    @hip_count = 0
    @waist_hip_ratio_count = 0

    @client.biosignatures.each do |biosignature|
      @chin_count = @chin_count + 1 unless biosignature.chin.zero?
      @cheek_count = @cheek_count + 1 unless biosignature.cheek.zero?
      @pec_count = @pec_count + 1 unless biosignature.pec.zero?
      @tri_count = @tri_count + 1 unless biosignature.tri.zero?
      @subscap_count = @subscap_count + 1 unless biosignature.subscap.zero?
      @suprailiac_count = @suprailiac_count + 1 unless biosignature.suprailiac.zero?
      @midaxil_count = @midaxil_count + 1 unless biosignature.midaxil.zero?
      @umbilical_count = @umbilical_count + 1 unless biosignature.umbilical.zero?
      @knee_count = @knee_count + 1 unless biosignature.knee.zero?
      @calf_count = @calf_count + 1 unless biosignature.calf.zero?
      @quad_count = @quad_count + 1 unless biosignature.quad.zero?
      @ham_count = @ham_count + 1 unless biosignature.ham.zero?
      @waist_count = @waist_count + 1 unless biosignature.waist.zero?
      @hip_count = @hip_count + 1 unless biosignature.hip.zero?
      @waist_hip_ratio_count = @waist_hip_ratio_count + 1 unless biosignature.waist.zero? or biosignature.hip.zero?
    end
  end
end
