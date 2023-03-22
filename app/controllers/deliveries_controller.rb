class DeliveriesController < ApplicationController
  def index
    
    matching_deliveries = Delivery.where({:user_id => session.fetch(:user_id) })

    @list_of_deliveries = matching_deliveries.order({ :created_at => :desc })
    @list_of_working_deliveries = matching_deliveries.where({ :status => "waiting_on" })
    @received = matching_deliveries.where({ :status => "received" })

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
    the_delivery.status = "waiting_on"
    the_delivery.user_id = session.fetch(:user_id)

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/", { :notice => "Added to list." })
    else
      redirect_to("/", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.status = params.fetch("arrived")
    
    the_delivery.status = "received"
    the_delivery.user_id = session.fetch(:user_id)

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", { :notice => "Marked as received."} )
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.destroy

    redirect_to("/", { :notice => "Deleted."} )
  end
end
