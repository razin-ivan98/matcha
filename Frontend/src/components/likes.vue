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

    <div v-if="waiting === false">
      <b-container>
        <b-card>
          <b-card
            v-for="(like, key) in likes"
            :key="key"
            :img-src="'/api/get_avatar?username=' + like.liker"
            :bg-variant="like.type === 'unlike' ? 'danger' : 'default'"
            :text-variant="like.type === 'unlike' ? 'white' : 'black'"
            img-left
            img-width="80"
            img-height="80"
          >
            {{ like.firstname + " " + like.lastname + like.type }}
            <b-button
              @click="$router.push('/profile/' + like.liker)"
              variant="primary"
              >Profile</b-button
            >
            <b-button
              v-if="like.got === 0"
              @click="likeRead(like.id)"
              style="position: inline block"
              variant="success"
              >Got it</b-button
            >
          </b-card>
        </b-card>
      </b-container>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "likes",

  data() {
    return {
      interval: null,
      waiting: true,
      likes: []
    };
  },

  methods: {
    likeRead(like_id) {
      var self = this;
      axios.get("/api/like_read?like_id=" + like_id).then(function() {
        self.$emit("update");
        self.getLikes();
      });
    },
    getLikes() {
      var self = this;
      axios.get("/api/get_likes").then(function(response) {
        if (response.data.answer === true) {
          self.likes = response.data.likes;
        }
        self.waiting = false;
      });
    }
  },
  computed: {},
  mounted() {
    const self = this;
    this.getLikes();
    this.interval = setInterval(() => {
      self.getLikes();
    }, 5000);
  },
  beforeDestroy() {
    clearInterval(this.interval);
  }
};
</script>
