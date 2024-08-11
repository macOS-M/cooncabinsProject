module ApplicationHelper
    def review_image(rating)
        case rating
        when 1 then 'scream.png'        
        when 2 then 'cry.png'       
        when 3 then 'huh.png'       
        when 4 then 'amazing.png'      
        when 5 then 'love.png'    # Amazing
        else 'default.png'           # Default case, if needed
        end
      end
end
