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
  end
end
