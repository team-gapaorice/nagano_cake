class Admin::OrdersController < ApplicationController
  bofore_action :authenticate_admin!
end
