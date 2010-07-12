class LogsController < ApplicationController
  layout "admin"
  before_filter :require_user # => add some authentication

  LOG_PATH = Rails.root.join("log", "#{RAILS_ENV}.log")
  
  def show
    if params[:filter]
      reg_expression = Regexp.new('\[' + params[:filter] + '\](.+)\[\/' + params[:filter] + '\]', true)
      @log_content = File.read(LOG_PATH).scan(reg_expression).join("\n")
    else
      @log_content = File.read(LOG_PATH)
    end
    @log_size = File.size?(LOG_PATH).to_f/1048576 #converts file size to MB 

  end
  
  def backup
    send_file LOG_PATH, 
      :type => "text/plain",
      :stream => false,
      :filename => "log_backup_#{Date.today}.txt"
  end

  def destroy
    File.open(LOG_PATH, "w") do |log_file|
      log_file.write "Log file cleared at #{Time.now}\n"
    end
    flash[:notice]  = "log was cleared\n"
    redirect_to log_path
  end

end
