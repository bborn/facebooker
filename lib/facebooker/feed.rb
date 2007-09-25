module Facebooker
  module Feed
    METHODS = {'Action' => 'facebook.feed.publishActionOfUser', 'Story' => 'facebook.feed.publishStoryToUser'}
    ##
    # Representation of a story to be published into a user's news feed.
    class Story
      attr_accessor :title, :body
      1.upto(4) do |num|
        attr_accessor "image_#{num}"
        attr_accessor "image_#{num}_link"
      end
      
      ##
      # Converts Story to a Hash of its attributes for use as parameters to Facebook REST API calls
      def to_params
        raise "Must set title before converting" if self.title.nil?
        {:title => title, :body => body}.merge image_params
      end
      
      private
      def image_params
        image_hash = {}
        1.upto(4) do |num|
          image_attribute = "image_#{num}"
          image_link_attribute = image_attribute + "_link"
          self.__send__(image_attribute) ? image_hash[image_attribute] = self.__send__(image_attribute) : nil
          self.__send__(image_link_attribute) ? image_hash[image_link_attribute] = self.__send__(image_link_attribute) : nil    
        end
        image_hash
      end
      
    end
    Action = Story.dup
    def Action.name
      "Action"
    end
    ##
    #  Representation of an action to be published into a user's news feed.  Alias for Story.
    class Action; end
  end
end