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
        <b-card-group deck class="mx-auto mb-3" style="max-width: 80rem;">
          <b-card
            border-primary
            v-for="(user, key) in users"
            :key="key"
            :title="user.firstname + ' ' + user.lastname"
            :img-src="'/api/download_image?avatar=' + user.avatar"
            img-alt="Image"
            img-top
            tag="article"
            class="mt-3 border-success"
            style="min-width: 17rem; max-width: 30rem; display: inline-block"
            footer-tag="footer"
          >
            <b-card-text>{{
              "Был в сети " + get_online(user.online)
            }}</b-card-text>

            <b-card-text>{{ user.gender }}</b-card-text>

            <b-card-text>{{ user.orientation }}</b-card-text>

            <b-card-text>{{ user.location }}</b-card-text>

            <b-button
              @click="$router.push('/profile/' + user.name)"
              variant="primary"
              >Profile</b-button
            >
            <b-button
              @click="
                like(user.name);
                user.liked = true;
              "
              v-if="user.liked == false"
              variant="success"
              >Like</b-button
            >
            <b-button
              @click="
                unlike(user.name);
                user.liked = false;
              "
              v-else
              variant="danger"
              >Unlike</b-button
            >
            <b-button
              @click="$router.push('/chat/' + user.name)"
              variant="success"
              v-if="user.liked == true && user.liked_me == true"
              >Chat</b-button
            >

            <template
              v-slot:footer
              v-if="user.liked_me == true && user.liked == true"
            >
              <em class="text-success">This user is Your friend</em>
            </template>
            <template
              v-slot:footer
              v-else-if="user.liked_me == true && user.liked == false"
            >
              <em class="text-success">This user liked You</em>
            </template>
          </b-card>
        </b-card-group>
        <b-pagination
          @input="paginationInput"
          v-model="currentPage"
          :total-rows="pagesCount"
          :per-page="1"
          aria-controls="my-table"
          align="center"
        ></b-pagination>
        <div style="height: 5rem"></div>
      </b-container>
    </div>

    <b-navbar variant="success" fixed="bottom">
      <b-card no-body class="mb-1 w-75 mx-auto">
        <b-card-header header-tag="header" class="p-0" role="tab">
          <b-button v-b-toggle.accordion-1 variant="success" class="w-100"
            >Filtres</b-button
          >
        </b-card-header>
        <b-collapse id="accordion-1" class="mt-2">
          <b-card-body>
            <b-form-group>
              <b-form-radio v-model="filtres.show" value="all"
                >All users</b-form-radio
              >
              <b-form-radio v-model="filtres.show" value="recommended"
                >Recommended</b-form-radio
              >
              <b-form-radio v-model="filtres.show" value="friends"
                >Friends</b-form-radio
              >
              <b-form-radio v-model="filtres.show" value="likers"
                >Likers</b-form-radio
              >
              <b-form-radio v-model="filtres.show" value="liked"
                >Liked</b-form-radio
              >
              <b-form-radio v-model="filtres.show" value="custom"
                >Custom filtres</b-form-radio
              >
              <b-form-group v-if="filtres.show == 'custom'">
                <b-form-group label="Gender">
                  <b-form-checkbox-group
                    id="checkbox-group-2"
                    v-model="filtres.gender"
                    name="flavour-2"
                  >
                    <b-form-checkbox value="Male">Male</b-form-checkbox>
                    <b-form-checkbox value="Female">Female</b-form-checkbox>
                    <b-form-checkbox value="Teapot">Teapot</b-form-checkbox>
                    <b-form-checkbox value="Transgender"
                      >Transgender</b-form-checkbox
                    >
                  </b-form-checkbox-group>
                </b-form-group>

                <b-form-group label="Orientation">
                  <b-form-checkbox-group
                    id="checkbox-group-3"
                    v-model="filtres.orientation"
                    name="flavour-2"
                  >
                    <b-form-checkbox value="Natural">Natural</b-form-checkbox>
                    <b-form-checkbox value="Gomosexual"
                      >Gomosexual</b-form-checkbox
                    >
                    <b-form-checkbox value="Bisexual">Bisexual</b-form-checkbox>
                    <b-form-checkbox value="Pidor">Pidor</b-form-checkbox>
                  </b-form-checkbox-group>
                </b-form-group>
              </b-form-group>
            </b-form-group>
          </b-card-body>
        </b-collapse>
      </b-card>
    </b-navbar>
  </div>
</template>

<script>
import axios from "axios";

import moment from "moment";

export default {
  name: "user",

  data() {
    return {
      pagesCount: 1,
      currentPage: 1,

      filtres: {
        show: "all",
        gender: [],
        orientation: []
      },
      users: ["ololo"],
      waiting: true
    };
  },

  methods: {
    paginationInput(e) {
      this.get_users();
    },
    like(username) {
      axios.get("/api/like?username=" + username).then();
    },
    unlike(username) {
      axios.get("/api/unlike?username=" + username).then();
    },
    get_users() {
      this.waiting = true;
      var self = this;
      // console.log(this.currentPage);
      axios
        .get(
          "/api/get_recomended_users?filtres=" +
            JSON.stringify(this.filtres) +
            "&page=" +
            this.currentPage
        )
        .then(function(response) {
          if (response.data.answer === true) {
            self.users = response.data.users;
            self.pagesCount = response.data.pages;
            // console.log(self.users);
            self.waiting = false;
          } else {
            ////////////////////////////////
          }
        });
    },

    get_online(str) {
      return moment().unix() - moment(str, "DD-MM-YYYY hh:mm:ss").unix() < 100
        ? "В Сети"
        : moment(str, "DD-MM-YYYY hh:mm:ss").fromNow();
    }
  },

  computed: {
    username() {
      return this.$store.getters.username;
    }
  },

  watch: {
    filtres: {
      handler: function(val) {
        this.get_users();
      },
      deep: true
    }
  },

  mounted() {
    this.get_users();
    moment.locale("ru");
  }
};
</script>

<style>
.as {
  background-color: green;
}
</style>
