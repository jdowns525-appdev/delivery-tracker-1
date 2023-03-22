class DeliveriesController < ApplicationController
  def index
    
    matching_deliveries = Delivery.all

    @list_of_deliveries = matching_deliveries.order({ :created_at => :desc })
    @working_on = matching_deliveries.where( :status => "working_on")
    @done = matching_deliveries.where( :status => "recieved")

    render({ :template => "deliveries/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_deliveries = Delivery.where({ :id => the_id })

    @the_delivery = matching_deliveries.at(0)

    render({ :template => "deliveries/show.html.erb" })
  end

  def create
    the_delivery = Delivery.new
    
    the_delivery.detail = params.fetch("query_details")
    the_delivery.description = params.fetch("query_description")
    the_delivery.status = "received"
    the_delivery.user_id = session.fetch(:user_id)

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/", { :notice => "Delivery created successfully." })
    else
      redirect_to("/", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.status = params.fetch("received")
    #the_delivery.description = params.fetch("q")
    the_delivery.user_id = session.fetch(:user_id)

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", { :notice => "Delivery updated successfully."} )
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.destroy

    redirect_to("/", { :notice => "Delivery deleted successfully."} )
  end
end
