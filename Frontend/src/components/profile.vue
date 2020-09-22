<template>
  <div>
    <div class="text-center" v-if="waiting === true">
      <b-spinner
        variant="warning"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        class="mt-5"
      ></b-spinner>
    </div>

    <b-container v-if="waiting === false">
      <b-row>
        <b-col>
          <b-card>
            <div>
              <b-carousel
                id="carousel-fade"
                style="text-shadow: 0px 0px 2px #000"
                fade
                indicators
                img-width="480"
                img-height="480"
              >
                <b-carousel-slide
                  v-for="im in user_info.images"
                  :key="im.id"
                  :img-src="'/api/download_image?avatar=' + im.url"
                ></b-carousel-slide>
              </b-carousel>
            </div>
            <template
              v-slot:footer
              v-if="user_info.liked_me == true && user_info.liked == true"
            >
              <em class="text-success">This user is Your friend</em>
            </template>
            <template
              v-slot:footer
              v-else-if="user_info.liked_me == true && user_info.liked == false"
            >
              <em class="text-success">This user liked You</em>
            </template>
          </b-card>
          <b-card class="mt-4">
            <b-button
              @click="
                like(user_info.name);
                user_info.liked = true;
              "
              v-if="user_info.liked == false"
              variant="success"
              >Like</b-button
            >
            <b-button
              @click="
                unlike(user_info.name);
                user_info.liked = false;
              "
              v-else
              variant="danger"
              >Unlike</b-button
            >
            <b-button
              @click="$router.push('/chat/' + user_info.name)"
              variant="success"
              v-if="user_info.liked == true && user_info.liked_me == true"
              >Chat</b-button
            >

            <b-button @click="report(user_info.name)" variant="warning"
              >Report</b-button
            >
          </b-card>
        </b-col>
        <b-col>
          <b-card :title="user_info.firstname + ' ' + user_info.lastname">
            <b-card-text>Age: {{ user_info.age }}</b-card-text>
            <b-card-text>Orientation: {{ user_info.orientation }}</b-card-text>
            <b-card-text>Gender: {{ user_info.gender }}</b-card-text>
            <b-card-text>Rating: {{ user_info.rating }}</b-card-text>
            <b-card-text>Location: {{ user_info.location }}</b-card-text>
            <b-card-text
              >Interests:
              <b-badge
                class="mx-1"
                v-for="interest in user_info.interests"
                :key="interest"
              >
                {{ interest }}
              </b-badge>
            </b-card-text>
          </b-card>
          <b-card title="Biography" class="mt-4">
            <b-card-text>{{ user_info.biography }}</b-card-text>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "my_profile",

  data() {
    return {
      username: this.$route.params.username,
      waiting: true,

      user_info: null
    };
  },
  methods: {
    like(username) {
      axios.get("/api/like?username=" + username).then();
    },
    unlike(username) {
      axios.get("/api/unlike?username=" + username).then();
    },
    report(username) {
      axios.get("/api/report?username=" + username).then();
    }
  },
  watch: {
    $route(to, from) {
      this.username = this.$route.params.username;
    }
  },

  mounted() {
    var self = this;
    axios.get("/api/visit?username=" + this.username).then();
    axios.get("/api/get_user_info?username=" + this.username).then(
      function(response) {
        if (response.data.answer === true) {
          self.user_info = response.data.user_info;
          self.user_info.interests = JSON.parse(self.user_info.interests);
          self.waiting = false;
        } else {
          self.$router.push("/404");
        }
      },
      function(error) {}
    );
  }
};
</script>
