module Sextant
  class RouteInfoController < Sextant::ApplicationController
    require 'method_source'
    require_relative '../../schema_scraper.rb'
    layout 'sextant/application'


    def index
      @route = Sextant.format_routes[params[:id].to_i || 0]
      controller_class, controller_method, file, line = find_controller(@route[:reqs])
      @controller_info = "Controller method '##{controller_method}' is defined in #{file}, line #{line}"
      @file = get_source_code(controller_class, controller_method)
      @info = database_info
      p @info
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

    def database_info
      db = File.open('db/schema.rb', "rb")
      text = []
      db.each_line do |line|
        text << line.strip.split
      end
      scraped_schema = Schema_scraper.new(text).scrape_schema
      scraped_schema.each do |table_array|
        if File.exist?("app/models/#{table_array[0].singularize}.rb")
          File.open("app/models/#{table_array[0].singularize}.rb").each_line do |line|
            table_array << line.strip.gsub(/[^0-9a-z]/,' ') if line.include?("belongs_to") || line.include?('has_many')
          end
        end
      end
    end
  end
end
