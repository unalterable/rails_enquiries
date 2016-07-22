class Schema_scraper

  attr_reader :table_contents

  def initialize(text)
    @text = text
    @table = false
    @current_table = []
    @table_contents = []
  end


  def scrape_schema
    @text.each do |line|
      end_in_line?(line)
      create_table_in_line?(line)
      @current_table << line[1].gsub(/[^0-9a-z]/,' ').strip if @table
    end
    prepare_table_contents(@table_contents)
    @table_contents
  end

  private

  def create_table_in_line?(line_text)
    @table = true if line_text.include?('create_table')
  end

  def end_in_line?(line_text)
    if line_text.include?('end')
      @table = false
      @current_table << "MODELLING"
      @table_contents << @current_table
      @current_table = []
    end
  end

  def prepare_table_contents(array)
    array.delete_if{ |a| a.length == 1}
    array.each do |a|
      a[0].capitalize!
    end
  end
end
