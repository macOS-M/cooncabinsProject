module ApplicationHelper
    def review_image(rating)
        case rating
        when 1 then '1.png'        
        when 2 then '2.png'       
        when 3 then '3.png'       
        when 4 then '4.png'      
        when 5 then '5.png'    
        else '0.png'           
        end
      end
end
