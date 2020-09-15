<template>
  <div>
    <b-card title="Sign In" style="max-width: 20rem;" class="mb-2 mt-5 mx-auto">
      <b-form @submit.prevent="onSubmit">
        <b-form-group id="input-group-1" label="Login:" label-for="input-1">
          <b-form-input
            id="input-1"
            v-model="form.login"
            type="text"
            required
            placeholder="Enter your login"
          ></b-form-input>
        </b-form-group>

        <b-form-group
          id="input-group-2"
          label="Your Password:"
          label-for="input-2"
        >
          <b-form-input
            id="input-2"
            v-model="form.password"
            type="password"
            required
            placeholder="Enter your password"
          ></b-form-input>
        </b-form-group>
        <p>
          <b-button type="submit" variant="primary">Submit</b-button>
          <b-button type="reset" variant="danger" class="ml-2">Reset</b-button>
        </p>
      </b-form>
      <p><router-link to="/sign_up">Sign Up</router-link></p>
      <p>
        <router-link to="/password_recovery_order/"
          >Password Recovery</router-link
        >
      </p>
      <b-alert
        :show="dismissCountDown"
        dismissible
        fade
        :variant="variant"
        @dismiss-count-down="countDownChanged"
      >
        Error
      </b-alert>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "signIn",

  data() {
    return {
      form: {},
      variant: "danger",
      dismissSecs: 5,
      dismissCountDown: 0,
      showDismissibleAlert: false
    };
  },

  methods: {
    onSubmit() {
      var self = this;
      axios.post("/api/sign_in", this.form).then(
        function(response) {
          //console.log(response);
          //alert(response.data.answer);
          if (response.data.answer === true) {
            self.$emit("signed-in");
          } else self.showAlert("danger");
        },
        function(error) {
          console.log(error);
          self.showAlert("danger", "Error");
        }
      );
    },

    countDownChanged(dismissCountDown) {
      this.dismissCountDown = dismissCountDown;
    },
    showAlert(variant) {
      this.variant = variant;
      this.dismissCountDown = this.dismissSecs;
    }
  }
};
</script>
