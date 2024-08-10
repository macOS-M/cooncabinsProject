module ApplicationHelper
    def review_image(rating)
        case rating
        when 1 then 'cry.png'        # Cry (worst)
        when 2 then 'what.png'       # What
        when 3 then 'huh.png'        # Huh
        when 4 then 'blush.png'      # Blush
        when 5 then 'amazing.png'    # Amazing
        when 6 then 'love.png'       # Love (best)
        else 'default.png'           # Default case, if needed
        end
      end
end
