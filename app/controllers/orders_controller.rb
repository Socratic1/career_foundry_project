class OrdersController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json, :html

    def index
        @orders = Order.all.to_json(:include => [{:product => {:only => :name}},
                                                 {:user => {:only => :email}}])
        respond_with @orders
    end

    def show
        @order = Order.find(params[:id]).to_json(:include => [{:product => {:only => :name}},
                                                              {:user => {:only => :email}}])
        respond_with @order
    end

    def new
        @order = Order.new
        @order.user = User.find(params[:user_id])
        @order.product = Product.find(params[:product_id])
        @customer = Stripe::Customer.retrieve(params[:customer_id])
    end

    def create
        @order = Order.new
        @order.product = Product.find(params[:product_id])
        @order.user = current_user

        @customer = Stripe::Customer.retrieve(params[:customer_id])

        begin
            charge = Stripe::Charge.create(
                :amount => @order.product.amount, #amount in cents, again
                :currency => "eur",
                :description => params[:stripeEmail],
                :customer => @customer.id,
                :metadata => {"order_id" => @order.id}
            )


        rescue Stripe::CardError => e
            # The card has been declined
            body = e.json_body
            err = body[:error]
            flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
        end
    
        OrderMailer.order_confirmation(@order.product, @order.user.email, @order.user.first_name)

        respond_to do |format|
            if @order.save
                format.html { redirect_to @order.product, notice: 'Your order was successful.' }
                format.json { render :show, status: :created, location: @order.product }
            else
                format.html { render :new }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        respond_with Order.destroy(params[:id])
    end

    def order_params
        params.require(:order).permit(:product_id, :user_id, :total)
    end

end