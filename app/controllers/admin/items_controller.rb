class Admin::ItemsController < ApplicationController
  bofore_action :authenticate_admin!
end
