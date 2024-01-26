class Admin::GenresController < ApplicationController
  bofore_action :authenticate_admin!
end
