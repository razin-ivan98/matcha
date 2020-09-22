import math
import json

class Filtres():

    def dist(self, lat1, long1, lat2, long2):
        R = 6372795
        lat1 *= math.pi / 180
        lat2 *= math.pi / 180
        long1 *= math.pi / 180
        long2 *= math.pi / 180

        cl1 = math.cos(lat1)
        cl2 = math.cos(lat2)
        sl1 = math.sin(lat1)
        sl2 = math.sin(lat2)
        delta = long2 - long1
        cdelta = math.cos(delta)
        sdelta = math.sin(delta)

        y = math.sqrt(math.pow(cl2 * sdelta, 2) + math.pow(cl1 * sl2 - sl1 * cl2 * cdelta, 2))
        x = sl1 * sl2 + cl1 * cl2 * cdelta
        ad = math.atan2(y, x)
        dist = ad * R
        return dist / 1000




    def main_filter(self, user):
        if (user['register_data'] and 
            user['register_image'] and
            user['register_geo']):
            return 1
        else:
            return 0

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
    
    def male_filter(self, users):
        return self.gender_filter(users, ['Male',])
    def female_filter(self, users):
        return self.gender_filter(users, ['Female',])

    def gomo_and_bi_filter(self, users):
        return self.orientation_filter(users, ['Gomosexual', 'Bisexual'])
    def natural_and_bi_filter(self, users):
        return self.orientation_filter(users, ['Natural', 'Bisexual'])

    def for_bi_male(self, users):
        new = []
        for user in users:
            if not ((user['gender'] == 'Male' and user['orientation'] == 'Natural')
                    or (user['gender'] == 'Female' and user['orientation'] == 'Gomosexual')):
                new.append(user)
        return new

    def for_bi_female(self, users):
        new = []
        for user in users:
            if not ((user['gender'] == 'Male' and user['orientation'] == 'Gomosexual')
                    or (user['gender'] == 'Female' and user['orientation'] == 'Natural')):
                new.append(user)
        return new
        
    def age_filter(self, users, age):
        new = []
        for user in users:
            if user['age'] >= age[0] and user['age'] <= age[1]:
                new.append(user)
        return new
    def rating_filter(self, users, rating):
        new = []
        for user in users:
            if user['rating'] >= rating[0] and user['rating'] <= rating[1]:
                new.append(user)
        return new


    def geo_filter(self, users, geo, signed_user):
        new = []
        for user in users:
            lat1 = user['latitude']
            long1 = user['longitude']
            lat2 = signed_user['latitude']
            long2 = signed_user['longitude']
            dist = self.dist(lat1, long1, lat2, long2)
            if (dist >= geo[0] and dist <= geo[1]):
                new.append(user)
        return new

    def common_tags_filter(self, users, common_tags, signed_user):
        new = []
        for user in users:
            user_tags = json.loads(user['interests'])
            signed_user_tags = json.loads(signed_user['interests'])

            count = len(list(set(user_tags) & set(signed_user_tags)))

            if count >= common_tags[0] and count <= common_tags[1]:
                new.append(user)
        return new
    
    def geo_sort(self, users, user):
        lat1 = user['latitude']
        long1 = user['longitude']
        def key_f(x):
            lat2 = x['latitude']
            long2 = x['longitude']
            
            dist_x = self.dist(lat1, long1, lat2, long2)

            return dist_x
        res = sorted(users, key=key_f)
        return res

    def common_tags_sort(self, users, user):
        signed_user_tags = json.loads(user['interests'])
        def key_f(x):
            tags = json.loads(x['interests'])
            return len(list(set(signed_user_tags) & set(tags)))
        res = sorted(users, key=key_f, reverse=True)
        return res