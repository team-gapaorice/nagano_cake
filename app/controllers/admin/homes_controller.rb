class Admin::HomesController < ApplicationController
  bofore_action :authenticate_admin!
end
