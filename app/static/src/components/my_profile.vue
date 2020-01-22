<template>
  <div>
    <b-container>
      <b-row>
        <b-col>
          <b-card>
            <b-img
              class="w-100"
              :src=" '/api/download_image?avatar=' + user_info.avatar"
              rounded
              alt="Rounded image"
            ></b-img>
          </b-card>
        </b-col>
        <b-col>
          <b-card :title="user_info.firstname + ' ' + user_info.lastname">
            <b-card-text>Age: {{ user_info.age }}</b-card-text>
            <b-card-text>Orientation: {{ user_info.orientation }}</b-card-text>
            <b-card-text>Gender: {{ user_info.gender }}</b-card-text>
            <b-card-text>Rating: {{ user_info.rating }}</b-card-text>
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