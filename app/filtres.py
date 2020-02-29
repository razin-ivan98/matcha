class Filtres():
    def likers_filter(self, user):
        if user['liked_me'] == True:
            return 1
        else:
            return 0

    def liked_filter(self, user):
        if user['liked'] == True:
            return 1
        else:
            return 0

    def friends_filter(self, user):
        if user['liked_me'] == True and user['liked'] == True:
            return 1
        else:
            return 0

    def orientation_filter(self, users, orientations):
        new = []
        for user in users:
            if user['orientation'] in orientations:
                new.append(user)
        return new

    def gender_filter(self, users, genders):
        new = []
        for user in users:
            if user['gender'] in genders:
                new.append(user)
        return new