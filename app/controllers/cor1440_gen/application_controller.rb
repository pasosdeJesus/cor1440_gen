# encoding: UTF-8
require 'sip/application_controller'
module Cor1440Gen
  class ApplicationController < Sip::ApplicationController
    protect_from_forgery with: :exception
  end
end
