class Restaurant < ApplicationRecord
    mount_uploader :image, S3Uploader
   
    has_many :zizuminfos
    has_many :menus

    validates :restaurant_name, :uniqueness => true
    #acts_as_followable

    def self.RestaurantName
        if Restaurant.where(restaurant_name: "서브웨이")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "서브웨이"
            r.save
        end

        if Restaurant.where(restaurant_name: "맘스터치")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "맘스터치"
            r.save
        end

        if Restaurant.where(restaurant_name: "빕스")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "빕스"
            r.save
        end
        
        # ## 4 
        # if Restaurant.where(restaurant_name: "라라코스트")[0].nil?
        #     r = Restaurant.new
        #     r.restaurant_name = "라라코스트"
        #     r.save
        # end

        ## 4
        if Restaurant.where(restaurant_name: "커피빈")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "커피빈"
            r.save
        end

        ## 5
        if Restaurant.where(restaurant_name: "파파이스")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "파파이스"
            r.save
        end

        ## 6 
        if Restaurant.where(restaurant_name: "배스킨라빈스")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "배스킨라빈스"
            r.save
        end

        ## 7
        if Restaurant.where(restaurant_name: "피자스쿨")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "피자스쿨"
            r.save
        end

        ## 8
        if Restaurant.where(restaurant_name: "계절밥상")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "계절밥상"
            r.save
        end

        ## 9
        if Restaurant.where(restaurant_name: "버거킹")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "버거킹"
            r.save
        end

        ## 10
        if Restaurant.where(restaurant_name: "던킨도너츠")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "던킨도너츠"
            r.save
        end
  
        ## 11
        if Restaurant.where(restaurant_name: "스시히로바")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "스시히로바"
            r.save
        end
    end
end
