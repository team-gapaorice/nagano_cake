class Admin::CustomersController < ApplicationController
  bofore_action :authenticate_admin!
end
