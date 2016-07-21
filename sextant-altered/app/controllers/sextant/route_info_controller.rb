module Sextant
  class RouteInfoController < Sextant::ApplicationController
    require 'method_source'
    layout 'sextant/application'


    def index
      redirect_to('/rails_enquiries/routes') unless !!params[:route_id]
      route = Sextant.format_routes[params[:route_id].to_i][:reqs]
      controller_class, controller_method, file, line = find_controller(route)

      @controller_info = "Controller method '##{controller_method}' is defined in #{file}, line #{line}"
      @file = get_source_code(controller_class, controller_method)
    end

     private

     def find_controller (route)
       controller, controller_method = route.split('#')
       controller_class = eval((controller + '_controller').classify)
       file, line = controller_class.instance_method(controller_method.to_sym).source_location
       [controller_class, controller_method, file, line]
     end

     def get_source_code(klass, method)
       klass.instance_method(method.to_sym).source.gsub("\n", "<br>").html_safe
     end

  end
end
