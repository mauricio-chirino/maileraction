module Api
  module V1
    module Admin
      class IndustriesController < ApplicationController
        # before_action :authenticate_user! # o :authorize_admin!

        def reset_counts
          ResetIndustryEmailCountsJob.perform_later
          render json: { message: "Recalculando contadores de emails por industria..." }, status: :accepted
        end
      end
    end
  end
end
