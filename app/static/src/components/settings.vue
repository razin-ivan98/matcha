<template>
  <div>
    <b-card title="Settings" style="max-width: 50rem;" class="mb-2 mt-5 mx-auto">
      
        <b-tabs content-class="mt-3">
          <b-tab :active="this.activeTab === 1" title="Data">

          </b-tab>
          <b-tab title="Images" :active="this.activeTab === 2">
            <b-form @submit.prevent="onNewImageSubmit">
            <b-form-group id="input-group-1">
              <b-form-file
                @input="onNewImageInput"
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
          </b-tab>
          <b-tab title="Map" :active="this.activeTab === 3">
            <div>
              <yandex-map style="width: 100%; height: 60vh;"
                :coords="this.mark || [55.755241123, 37.61777976876]"
                :settings="{
                  apiKey: 'abd98dea-8721-4425-be8a-398bb9fbab30',
                  lang: 'ru_RU',
                  coordorder: 'latlong',
                  version: '2.1'
                }"
                :controls="['geolocationControl', 'fullscreenControl', 'zoomControl']"
                @click="onClick">
                <ymap-marker v-if="this.mark"
                  :coords="this.mark"
                  marker-id="123" 
                  hint-content="some hint" 
                />
              </yandex-map>
            </div>
            <b-button @click="onMapSubmit" variant="primary">Submit</b-button>
          </b-tab>
        </b-tabs>
     

    </b-card>
  </div>
</template>

<script>
import axios from "axios";
import { Cropper } from "vue-advanced-cropper";
import { yandexMap, ymapMarker } from 'vue-yandex-maps';

export default {
  data() {
    return {
      activeTab: 1,
      mark: null,
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

  components: { Cropper, yandexMap, ymapMarker },

  methods: {
    crop() {
      const { coordinates, canvas } = this.$refs.cropper.getResult();
      this.coordinates = coordinates;
    },

    onClick(e) {
      this.mark = e.get('coords');
    },

    onNewImageInput() {
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
    onNewImageSubmit() {
      const self = this;
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
            self.form.file = null;
            self.image = null;
            self.activeTab = 3;
          },
          function(error) {
            console.log(error);
          }
        );
    },
    onMapSubmit() {
      const self = this;
      if (!self.mark) {
        alert("Отметьте свою геолокацию");
        return;
      }
      axios
        .post("/api/set_geo", { latitude: self.mark[0], longitude:self.mark[1] })
        .then(
          function(response) {
            console.log(response);
            alert(response.data.answer);
            self.mark = null;
            self.activeTab = 3;
          },
          function(error) {
            console.log(error);
          }
        );
    }
  }
};
</script>

