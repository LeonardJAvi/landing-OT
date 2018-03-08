module App
  # FrontsController
  class FrontController < AppController
    layout 'layouts/templates/application'

    def index
      @destinations = Destination.all
    end

    def destination
      @destination = Destination.find(params[:id])
      @currency    = params['currency']
      @q           = Plan.ransack(params[:q])

      if params[:q]
        #si el params tiene contenido
        if params[:q][:price_gteq]
          #Busqueda por precios
          @hotels     = Hotel.search_price(@destination.id, @currency, params[:q][:price_gteq], params[:q][:price_lteq])
          @plans      = Plan.search_price(@destination.id, @currency, params[:q][:price_gteq], params[:q][:price_lteq])
          @activities = Excursion.search_price(@destination.id, @currency, params[:q][:price_gteq], params[:q][:price_lteq])
        else
          #Busqueda por nombres de hoteles, planes y actividades
          @hotels      = Hotel.ransack(params[:q]).result
          @plans       = Plan.ransack(params[:q]).result
          @activities  = Excursion.ransack(params[:q]).result
        end

      else
        #Cuando el params va vacío
        @hotels      = @destination.hotels
        @plans       = @destination.plans
        @activities  = @destination.excursions
      end

    end

  end
end
