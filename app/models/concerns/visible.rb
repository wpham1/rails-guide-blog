# modules are kind of like a mixin
module Visible
        # allows a simpler way to add validations through a module
    extend ActiveSupport::Concern
    
    # creates valid statuses
    VALID_STATUSES = ['public', 'private', 'archived']
    # if the status is included in the array validate it
    included do
      validates :status, inclusion: { in: VALID_STATUSES }
    end

    # counts all public resources that include the Visible module
    class_methods do
      def public_count
        where(status: 'public').count
      end
    end

    # is the comment/article archived? 
    def archived?
      status == 'archived'
    end
  end