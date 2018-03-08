module Admin
  # DestinationsController
  class DestinationsController < AdminController
    before_action :set_destination, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /destinations
    def index
      @q = Destination.ransack(params[:q])
      destinations = @q.result(distinct: true)
      @objects = destinations.page(@current_page).order(position: :desc)
      @total = destinations.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to destinations_path(page: @current_page.to_i.pred, search: @query)
      end
      respond_to do |format|
        format.html
        format.xls { send_data(@destinations.to_xls) }
      end
    end

    # GET /destinations/1
    def show
    end

    # GET /destinations/new
    def new
      @destination = Destination.new
    end

    # GET /destinations/1/edit
    def edit
    end

    # POST /destinations
    def create
      @destination = Destination.new(destination_params)

      if @destination.save
        redirect(@destination, params)
      else
        render :new
      end
    end

    # PATCH/PUT /destinations/1
    def update
      if @destination.update(destination_params)
        redirect(@destination, params)
      else
        render :edit
      end
    end

    def clone
      @destination = Destination.clone_record params[:destination_id]

      if @destination.save
        redirect_to admin_destinations_path
      else
        render :new
      end
    end

    # DELETE /destinations/1
    def destroy
      @destination.destroy
      redirect_to admin_destinations_path, notice: actions_messages(@destination)
    end

    def destroy_multiple
      Destination.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_destinations_path(page: @current_page, search: @query),
        notice: actions_messages(Destination.new)
      )
    end

    def import
      Destination.import(params[:file])

      redirect_to(
        admin_destinations_path(page: @current_page, search: @query),
        notice: actions_messages(Destination.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      # @destination = Destination.find(params[:id])
      @destination = Destination.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def destination_params
      params.require(:destination).permit(:name, :subtitle, :banner, :slug)
    end

    def show_history
      get_history(Destination)
    end
  end
end
