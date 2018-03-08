module Admin
  # ExcursionsController
  class ExcursionsController < AdminController
    before_action :set_excursion, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    before_action :set_destination

    # GET /excursions
    def index
      @q = Excursion.ransack(@destination)
      excursions = @q.result(distinct: true).where(destination_id: @destination)
      @objects = excursions.page(@current_page).order(position: :desc)
      @total = excursions.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to admin_destination_excursions_path(page: @current_page.to_i.pred, search: @query)
      end
      respond_to do |format|
        format.html
        format.xls { send_data(@excursions.to_xls) }
      end
    end

    # GET /excursions/1
    def show
    end

    # GET /excursions/new
    def new
      @excursion = Excursion.new
    end

    # GET /excursions/1/edit
    def edit
    end

    # POST /excursions
    def create
      @excursion = Excursion.new(excursion_params)

      if @excursion.save
        if params.key?('_add_other')
          redirect_to new_admin_destination_excursion_path(params[:destination_id]), notice: actions_messages(@excursion)
        else
          redirect_to admin_destination_excursions_path
        end
      else
        render :new
      end
    end

    # PATCH/PUT /excursions/1
    def update
      if @excursion.update(excursion_params)
        # redirect(@excursion, params)
        redirect_to admin_destination_excursions_path
      else
        render :edit
      end
    end

    def clone
      @excursion = Excursion.clone_record params[:excursion_id]

      if @excursion.save
        redirect_to admin_destination_excursions_path
      else
        render :new
      end
    end

    # DELETE /excursions/1
    def destroy
      @excursion.destroy
      redirect_to admin_destination_excursions_path, notice: actions_messages(@excursion)
    end

    def destroy_multiple
      Excursion.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_destination_excursions_path(page: @current_page, search: @query),
        notice: actions_messages(Excursion.new)
      )
    end

    def import
      Excursion.import(params[:file])

      redirect_to(
        admin_destination_excursions_path(page: @current_page, search: @query),
        notice: actions_messages(Excursion.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_excursion
      @excursion = Excursion.find(params[:id])
    end

    def set_destination
      @destination = Destination.find(params[:destination_id])
    end

    # Only allow a trusted parameter "white list" through.
    def excursion_params
      params.require(:excursion).permit(:banner, :title, :subtitle, :days, :url, :type_activity, :coupon, :price, :destination_id, price: [ :cop, :usd ])
    end

    def show_history
      get_history(Excursion)
    end
  end
end
