<template>
  <div>
    <b-navbar
      toggleable="lg"
      type="dark"
      variant="success"
      fixed="top"
      v-if="this.username"
    >
      <router-link to="/" tag="b-navbar-brand">Matcha</router-link>
      <b-navbar-toggle target="nav-collapse">
        <b-badge v-if="likes + dialogs + guests > 0" variant="warning">{{
          likes + dialogs + guests
        }}</b-badge>
      </b-navbar-toggle>
      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <router-link to="/settings" tag="b-nav-item">Settings</router-link>

          <router-link to="/user" tag="b-nav-item">Feed</router-link>
          <router-link to="/my_profile" tag="b-nav-item">Profile</router-link>
          <router-link to="/blacklist" tag="b-nav-item">Blacklist</router-link>

          <router-link to="/likes" tag="b-nav-item">
            Likes
            <b-badge v-if="likes > 0" variant="warning">{{ likes }}</b-badge>
          </router-link>

          <router-link to="/guests" tag="b-nav-item">
            Guests
            <b-badge v-if="guests > 0" variant="warning">{{ guests }}</b-badge>
          </router-link>

          <router-link to="/chats" tag="b-nav-item">
            Chats
            <b-badge v-if="dialogs > 0" variant="warning">{{
              dialogs
            }}</b-badge>
          </router-link>
        </b-navbar-nav>
        <b-navbar-nav class="ml-auto">
          <b-nav-item-dropdown right>
            <template v-slot:button-content>
              <em>{{ username }}</em>
            </template>
            <b-dropdown-item href="#">Profile</b-dropdown-item>
            <b-dropdown-item @click="signOut">Sign Out</b-dropdown-item>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>

    <b-navbar toggleable="lg" type="dark" variant="success" fixed="top" v-else>
      <b-navbar-brand href="/">Matcha</b-navbar-brand>
    </b-navbar>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "headcomp",

  methods: {
    signOut() {
      this.$emit("signed-out");
    }
  },
  computed: {
    username() {
      return this.$store.getters.username;
    },
    likes() {
      return this.$store.getters.likes;
    },
    dialogs() {
      return this.$store.getters.dialogs;
    },
    guests() {
      return this.$store.getters.guests;
    },
    registration_ended() {
      return this.$store.getters.registration_ended;
    }
  }
};
</script>

<style>
router-link {
  text-decoration: none;
  color: #fff;
}
</style>
