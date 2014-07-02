class PagesController < ApplicationController
    def search
    search = params[:search]
    @results = []
      unless search == ""
        # Author.column_names[1..-3].each do #the search yadayada
        @results += Brand.where("name ILIKE :search", search: "%#{ search }%")
        @results += Type.where("name ILIKE :search", search: "%#{ search }%")
        @results += User.where("username ILIKE :search", search: "%#{ search }%")
      end
    end

end