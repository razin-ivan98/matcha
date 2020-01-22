<template>
  <div>
    <b-card title="Settings" style="max-width: 50rem;" class="mb-2 mt-5 mx-auto">
      <b-form @submit.prevent="onSubmit">
        <b-form-group id="input-group-1">
          <b-form-file
            @input="onInput"
            v-model="form.file"
            :state="Boolean(form.file)"
            placeholder="Choose a file or drop it here..."
            drop-placeholder="Drop file here..."
          ></b-form-file>
        </b-form-group>

        <b-form-group>
          <b-button type="submit" variant="primary">Submit</b-button>
          <b-button type="reset" variant="danger">Reset</b-button>
        </b-form-group>
      </b-form>
      <cropper
        ref="cropper"
        v-if="this.image != null"
        class="cropper"
        :src="this.image"
        :stencilProps="{
            aspectRatio: 10/10
          }"
        @change="change"
      ></cropper>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";
import { Cropper } from "vue-advanced-cropper";

export default {
  data() {
    return {
      image: null,
      form: {
        file: null
      },
      coordinates: {
        width: 0,
        height: 0,
        left: 0,
        top: 0
      }
    };
  },

  components: { Cropper },

  methods: {
    crop() {
      const { coordinates, canvas } = this.$refs.cropper.getResult();
      this.coordinates = coordinates;
    },

    onInput() {
      var reader = new FileReader();
      var self = this;
      reader.onloadend = function() {
        self.image = reader.result;
        console.log(self.image);
      };

      if (this.form.file) {
        reader.readAsDataURL(this.form.file);
        console.log("readed");
      } else {
        this.image = "";
      }
    },
    change({ coordinates, canvas }) {
      console.log(coordinates, canvas);
    },
    onSubmit() {
      this.crop();
      alert(this.coordinates.width);
      var forme = new FormData();
      forme.append("file", this.form.file);
      forme.append("coordinates", JSON.stringify(this.coordinates));
      // alert(this.form.file);
      axios
        .post("/api/upload_image", forme, {
          headers: {
            "Content-Type": "multipart/form-data"
          }
        })
        .then(
          function(response) {
            console.log(response);
            alert(response.data.answer);
          },
          function(error) {
            console.log(error);
          }
        );
    }
  }
};
</script>

