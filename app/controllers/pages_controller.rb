class PagesController < ApplicationController
    def search
    search = params[:search]
    @results = []
      unless search == ""
        # @results += Item.where("fit ILIKE :search", search: "%#{ search }%")
        @results += Brand.where("name ILIKE :search", search: "%#{ search }%")
        # @results += Brand.where("name ILIKE :search", search: "%#{ search }%").includes(:items).where.not(:items => {:brand_id => nil})
        # @results += Item.where("category ILIKE :search", search: "%#{ search }%")
        # @results += User.where("username ILIKE :search", search: "%#{ search }%")
      end
    end

end