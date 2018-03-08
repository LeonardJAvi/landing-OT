module Admin
  # PlansController
  class PlansController < AdminController
    before_action :set_plan, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    before_action :set_destination

    # GET /plans
    def index
      @q = Plan.ransack(@destination)
      plans = @q.result(distinct: true).where(destination_id: @destination)
      @objects = plans.page(@current_page).order(position: :desc)
      @total = plans.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to admin_destination_plans_path(page: @current_page.to_i.pred, search: @query)
      end
      respond_to do |format|
        format.html
        format.xls { send_data(@plans.to_xls) }
      end
    end

    # GET /plans/1
    def show
    end

    # GET /plans/new
    def new
      @plan = Plan.new
    end

    # GET /plans/1/edit
    def edit
    end

    # POST /plans
    def create
      @plan = Plan.new(plan_params)

      if @plan.save
        if params.key?('_add_other')
          redirect_to new_admin_destination_plan_path(params[:destination_id]), notice: actions_messages(@plan)
        else
          redirect_to admin_destination_plans_path
        end
      else
        render :new
      end
    end

    # PATCH/PUT /plans/1
    def update
      if @plan.update(plan_params)
        # redirect(@plan, params)
        redirect_to admin_destination_plans_path
      else
        render :edit
      end
    end

    def clone
      @plan = Plan.clone_record params[:plan_id]

      if @plan.save
        redirect_to admin_destination_plans_path
      else
        render :new
      end
    end

    # DELETE /plans/1
    def destroy
      @plan.destroy
      redirect_to admin_destination_plans_path, notice: actions_messages(@plan)
    end

    def destroy_multiple
      Plan.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_destination_plans_path(page: @current_page, search: @query),
        notice: actions_messages(Plan.new)
      )
    end

    def import
      Plan.import(params[:file])

      redirect_to(
        admin_destination_plans_path(page: @current_page, search: @query),
        notice: actions_messages(Plan.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def set_destination
      @destination = Destination.find(params[:destination_id])
    end

    # Only allow a trusted parameter "white list" through.
    def plan_params
      params.require(:plan).permit(:banner, :title, :subtitle, :days, :url, :price, :destination_id, :coupon, price: [ :cop, :usd ])
    end

    def show_history
      get_history(Plan)
    end
  end
end
