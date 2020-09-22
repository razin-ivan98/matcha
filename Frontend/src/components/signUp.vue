<template>
  <div>
    <b-card title="Sign Up" style="max-width: 20rem;" class="mb-2 mt-5 mx-auto">
      <b-form @submit.prevent="onSubmit">
        <b-form-group id="input-group-1" label="Yor login:" label-for="input-1">
          <b-form-input
            id="input-login"
            v-model="form.login"
            type="text"
            required
            placeholder="Enter your login"
          ></b-form-input>
        </b-form-group>

        <b-form-group
          id="input-group-2"
          label="Your password:"
          label-for="input-2"
        >
          <b-form-input
            id="input-password"
            v-model="form.password"
            type="password"
            required
            placeholder="Enter your password"
          ></b-form-input>
        </b-form-group>

        <b-form-group
          id="input-group-2"
          label="Confirm password:"
          label-for="input-2"
        >
          <b-form-input
            id="input-confirm-password"
            v-model="form.confirm_password"
            type="password"
            required
            placeholder="Confirm your password"
          ></b-form-input>
        </b-form-group>

        <b-button type="submit" variant="primary">Submit</b-button>
        <b-button type="reset" variant="danger" class="ml-2">Reset</b-button>
      </b-form>
      <router-link to="/sign_in">Sign In</router-link>
      <b-alert
        :show="dismissCountDown"
        dismissible
        fade
        :variant="variant"
        @dismiss-count-down="countDownChanged"
      >
        {{ text }}
      </b-alert>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "signUp",

  data() {
    return {
      variant: "danger",
      text: "",
      dismissSecs: 5,
      dismissCountDown: 0,
      showDismissibleAlert: false,
      form: {}
    };
  },

  methods: {
    onSubmit() {
      let self = this;
      axios.post("/api/sign_up", this.form).then(
        function(response) {
          if (response.data.answer) self.showAlert("success", "Success");
          else
            self.showAlert("danger", "Error: " + response.data.details || "");
        },
        function(error) {
          self.showAlert("danger", "Error");
        }
      );
    },
    countDownChanged(dismissCountDown) {
      this.dismissCountDown = dismissCountDown;
    },
    showAlert(variant, text) {
      this.variant = variant;

      this.text = text;

      this.dismissCountDown = this.dismissSecs;
    }
  }
};
</script>
