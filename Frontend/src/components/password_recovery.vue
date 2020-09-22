<template>
  <div>
    <b-card
      title="Password recovery"
      style="max-width: 50rem;"
      class="mb-2 mt-5 mx-auto"
    >
      <b-form @submit.prevent="onPassSubmit">
        <b-form-group
          id="pass-group-1"
          label="Your old Password"
          label-for="pass-input-1"
        >
          <b-form-input
            id="pass-input-1"
            v-model="passForm.oldPass"
            type="password"
            required
            placeholder="Enter old password"
          ></b-form-input
        ></b-form-group>
        <b-form-group
          id="pass-group-2"
          label="Your new Password"
          label-for="pass-input-2"
        >
          <b-form-input
            id="pass-input-2"
            v-model="passForm.newPass"
            type="password"
            required
            placeholder="Enter new password"
          ></b-form-input> </b-form-group
        ><b-form-group
          id="pass-group-3"
          label="Repeat new Password"
          label-for="pass-input-3"
          ><b-form-input
            id="pass-input-3"
            v-model="passForm.repeatPass"
            type="password"
            required
            placeholder="Repeat new password"
          ></b-form-input
        ></b-form-group>
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
  data() {
    return {
      variant: "danger",
      text: "",
      dismissSecs: 5,
      dismissCountDown: 0,
      showDismissibleAlert: false,
      passForm: {
        id: this.$route.params.id,
        oldPass: "",
        newPass: "",
        repeatPass: ""
      }
    };
  },
  watch: {
    $route(to, from) {
      this.passForm.id = this.$route.params.id;
    }
  },
  methods: {
    onPassSubmit() {
      var self = this;
      axios.post("/api/password_recovery/change", this.passForm).then(
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
