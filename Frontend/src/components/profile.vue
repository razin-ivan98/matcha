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
            <!-- <b-img
              class="w-100"
              :src=" '/api/download_image?avatar=' + user_info.avatar"
              rounded
              alt="Rounded image"
            ></b-img>-->
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

  // computed: {
  //   username() {
  //     return this.$route.params.username;
  //   }
  // },
  watch: {
    $route(to, from) {
      this.username = this.$route.params.username;
    }
  },

  mounted() {
    var self = this;
    console.log(this.username);
    axios.get("/api/get_user_info?username=" + this.username).then(
      function(response) {
        console.log(response.data);
        if (response.data.answer === true) {
          //commit("change_username", response.data.username);
          //commit("change_confirmed", response.data.confirmed);
          //commit("change_user_info", response.data.user_info);
          // console.log("done");
          self.user_info = response.data.user_info;
          self.user_info.interests = JSON.parse(self.user_info.interests);
          self.waiting = false;
        } else {
          //// commit("change_username", false);
          // console.log("done");
        }
      },
      function(error) {
        console.log(error);
      }
    );
  }
};
</script>
