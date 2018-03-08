module Admin
  # HotelsController
  class HotelsController < AdminController
    before_action :set_hotel, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    before_action :set_destination

    # GET /hotels
    def index
      @q = Hotel.ransack(@destination)
      hotels = @q.result(distinct: true).where(destination_id: @destination)
      @objects = hotels.page(@current_page).order(position: :desc)
      @total = hotels.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to admin_destination_hotels_path(page: @current_page.to_i.pred, search: @query)
      end
      respond_to do |format|
        format.html
        format.xls { send_data(@hotels.to_xls) }
      end
    end

    # GET /hotels/1
    def show
    end

    # GET /hotels/new
    def new
      @hotel = Hotel.new
    end

    # GET /hotels/1/edit
    def edit
    end

    # POST /hotels
    def create
      @hotel = Hotel.new(hotel_params)
      if @hotel.save
        if params.key?('_add_other')
          redirect_to new_admin_destination_hotel_path(params[:destination_id]), notice: actions_messages(@hotel)
        else
          redirect_to admin_destination_hotels_path
        end
      else
        render :new
      end
    end

    # PATCH/PUT /hotels/1
    def update
      if @hotel.update(hotel_params)
        # redirect(@hotel, params)
        redirect_to admin_destination_hotels_path
      else
        render :edit
      end
    end

    def clone
      @hotel = Hotel.clone_record params[:hotel_id]

      if @hotel.save
        redirect_to admin_destination_hotels_path
      else
        render :new
      end
    end

    # DELETE /hotels/1
    def destroy
      @hotel.destroy
      redirect_to admin_destination_hotels_path, notice: actions_messages(@hotel)
    end

    def destroy_multiple
      Hotel.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_destination_hotels_path(page: @current_page, search: @query),
        notice: actions_messages(Hotel.new)
      )
    end

    def import
      Hotel.import(params[:file])

      redirect_to(
        admin_destination_hotels_path(page: @current_page, search: @query),
        notice: actions_messages(Hotel.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    def set_destination
      @destination = Destination.find(params[:destination_id])
    end

    # Only allow a trusted parameter "white list" through.
    def hotel_params
      params.require(:hotel).permit(:banner, :title, :subtitle, :days, :url, :destination_id, :coupon, price: [ :cop, :usd ])
    end

    def show_history
      get_history(Hotel)
    end
  end
end
