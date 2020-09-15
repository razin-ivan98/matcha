<template>
  <div>
    <b-container>
      <b-row>
        <b-col>
          <b-card>
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

  computed: {
    user_info() {
      return this.$store.getters.user_info;
    }
  }
};
</script>
