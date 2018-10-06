class ForumThreadPolicy < ApplicationPolicy
    def edit?
        user.id == record.user.id || user.admin?
    end
     def update?
        user.id == record.user.id || user.admin?    
     end
     def destroy?
      user.id == user.admin?
    end

end