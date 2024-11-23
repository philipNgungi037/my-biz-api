class CategoriesController < ApplicationController
    skip_before_action :authorized, only: [:index]

    def index
        categories = Category.all
        render json: categories
    end

    def create
        category = Category.new(category_params)
        if category.save
          render json: category, status: :created
        else
          render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.require(:category).permit(:title, :img)
      end
end
