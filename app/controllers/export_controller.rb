class ExportController < ApplicationController
  before_action :set_config

  def index; end

  def pdf
    pdf = Grover.new('<h1>Hi!</h1>', format: 'A4').to_pdf
    send_data pdf, filename: 'export', type: 'application/pdf'
  end

  def set_config
    @config = {}

    Config.all.each do |c|
      @config[c.key] = c.value
    end
  end
end
