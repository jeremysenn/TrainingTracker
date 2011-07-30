class ClientsController < ApplicationController
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
    if @client.save
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
    if @client.update_attributes(params[:client])
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
end
