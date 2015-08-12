class HomeController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end
  
  def index
  end
end
