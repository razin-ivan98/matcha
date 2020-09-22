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
            v-for="(guest, key) in guests"
            :key="key"
            :img-src="'/api/get_avatar?username=' + guest.name"
            img-left
            img-width="80"
            img-height="80"
          >
            {{ guest.firstname + " " + guest.lastname }}
            <b-button
              @click="$router.push('/profile/' + guest.name)"
              variant="primary"
              >Profile</b-button
            >
            <b-button
              v-if="guest.got === 0"
              @click="guestRead(guest.id)"
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
  name: "guests",

  data() {
    return {
      interval: null,
      waiting: true,
      guests: []
    };
  },

  methods: {
    guestRead(guest_id) {
      var self = this;
      axios.get("/api/guest_read?guest_id=" + guest_id).then(function() {
        self.$emit("update");
        self.getGuests();
      });
    },
    getGuests() {
      var self = this;
      axios.get("/api/get_guests").then(function(response) {
        if (response.data.answer === true) {
          self.guests = response.data.guests;
        }
        self.waiting = false;
      });
    }
  },
  mounted() {
    const self = this;
    this.getGuests();
    this.interval = setInterval(() => {
      self.getGuests();
    }, 5000);
  },
  beforeDestroy() {
    clearInterval(this.interval);
  }
};
</script>
