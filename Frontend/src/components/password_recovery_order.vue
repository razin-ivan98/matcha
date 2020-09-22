<template>
  <div>
    <b-card
      title="Password recovery"
      style="max-width: 50rem;"
      class="mb-2 mt-5 mx-auto"
    >
      <b-form @submit.prevent="onPassRecoveryOrder">
        <b-form-group
          id="pass-group-1"
          label="Your Login"
          label-for="login-input-1"
        >
          <b-form-input
            id="login-input-1"
            v-model="passRecoveryOrderForm.username"
            type="text"
            required
            placeholder="Enter your login"
          >
          </b-form-input>
        </b-form-group>
        <p>
          <b-button type="submit" variant="primary">Submit</b-button>
          <b-button type="reset" variant="danger">Reset</b-button>
        </p>
      </b-form>
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
  name: "password_recovery_order",

  data() {
    return {
      variant: "danger",
      text: "",
      dismissSecs: 5,
      dismissCountDown: 0,
      showDismissibleAlert: false,
      passRecoveryOrderForm: {
        username: ""
      }
    };
  },
  methods: {
    onPassRecoveryOrder() {
      if (this.passRecoveryOrderForm.username === "") {
        /////////
        return;
      }
      let self = this;
      axios
        .get(
          "/api/password_recovery/get?username=" +
            self.passRecoveryOrderForm.username
        )
        .then(
          function(response) {
            if (response.data.answer) self.showAlert("success", "Success");
            else self.showAlert("danger", "Error: " + response.data.details);
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

<style></style>
