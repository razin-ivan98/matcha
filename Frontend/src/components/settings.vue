<template>
  <div>
    <b-card
      title="Settings"
      style="max-width: 50rem;"
      class="mb-2 mt-5 mx-auto"
    >
      <b-tabs content-class="mt-3">
        <b-tab :active="this.activeTab === 1" title="Data">
          <b-form @submit.prevent="onDataSubmit">
            <b-container>
              <b-row>
                <b-col>
                  <b-form-group
                    id="input-group-2"
                    label="Your FirstName:"
                    label-for="input-2"
                  >
                    <b-form-input
                      id="input-2"
                      v-model="dataForm.firstname"
                      required
                      placeholder="Enter your firstname"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-5"
                    label="Your LastName:"
                    label-for="input-5"
                  >
                    <b-form-input
                      id="input-5"
                      v-model="dataForm.lastname"
                      required
                      placeholder="Enter ypur lastname"
                    ></b-form-input>
                  </b-form-group>

                  <b-form-group
                    id="input-group-1"
                    label="Email address:"
                    label-for="input-1"
                  >
                    <b-form-input
                      id="input-1"
                      v-model="dataForm.email"
                      type="email"
                      required
                      placeholder="Enter email"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
                <b-col>
                  <b-form-group
                    id="input-group-6"
                    label="Gender:"
                    label-for="input-6"
                  >
                    <b-form-select
                      id="input-6"
                      v-model="dataForm.gender"
                      :options="dataSet.genders"
                      required
                    ></b-form-select>
                  </b-form-group>

                  <b-form-group
                    id="input-group-7"
                    label="Orientation:"
                    label-for="input-7"
                  >
                    <b-form-select
                      id="input-7"
                      v-model="dataForm.orientation"
                      :options="dataSet.orientations"
                      required
                    ></b-form-select>
                  </b-form-group>
                </b-col>
              </b-row>
            </b-container>

            <b-button type="submit" variant="primary">Submit</b-button>
            <b-button type="reset" variant="danger">Reset</b-button>
          </b-form>
        </b-tab>
        <b-tab title="Images" :active="this.activeTab === 2">
          <b-form @submit.prevent="onNewImageSubmit">
            <b-form-group id="input-group-1">
              <b-form-file
                @input="onNewImageInput"
                v-model="fileForm.file"
                :state="Boolean(fileForm.file)"
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
              aspectRatio: 10 / 10
            }"
            @change="change"
          ></cropper>
        </b-tab>
        <b-tab title="Map" :active="this.activeTab === 3">
          <div>
            <yandex-map
              style="width: 100%; height: 60vh;"
              :coords="this.mark || [55.755241123, 37.61777976876]"
              :settings="{
                apiKey: 'abd98dea-8721-4425-be8a-398bb9fbab30',
                lang: 'ru_RU',
                coordorder: 'latlong',
                version: '2.1'
              }"
              :controls="[
                'geolocationControl',
                'fullscreenControl',
                'zoomControl'
              ]"
              @click="onClick"
            >
              <ymap-marker
                v-if="this.mark"
                :coords="this.mark"
                marker-id="123"
                hint-content="some hint"
              />
            </yandex-map>
          </div>
          <b-button @click="onMapSubmit" variant="primary">Submit</b-button>
          <b-button @click="onMapDenial" variant="warning">Не скажу</b-button>
        </b-tab>
        <b-tab title="Password" :active="this.activeTab === 4">
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
            <b-button type="submit" variant="primary">Submit</b-button>
            <b-button type="reset" variant="danger">Reset</b-button>
          </b-form>
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";
import { Cropper } from "vue-advanced-cropper";
import { yandexMap, ymapMarker } from "vue-yandex-maps";
import input_data from "./input_data";

export default {
  data() {
    return {
      activeTab: 1,

      mark: [
        this.$store.getters.user_info.latitude,
        this.$store.getters.user_info.longitude
      ],
      image: null,
      fileForm: {
        file: null
      },
      dataForm: {
        firstname: this.$store.getters.user_info.firstname,
        lastname: this.$store.getters.user_info.lastname,
        gender: this.$store.getters.user_info.gender,
        orientation: this.$store.getters.user_info.orientation,
        email: this.$store.getters.user_info.email
      },
      dataSet: {
        genders: [
          { text: "Select One", value: null },
          "Male",
          "Female",
          "Transgender",
          "Teapot"
        ],
        orientations: [
          { text: "Select One", value: null },
          "Natural",
          "Bisexual",
          "Gomosexual",
          "Pidor"
        ]
      },
      passForm: {
        oldPass: "",
        newPass: "",
        repeatPass: ""
      },
      coordinates: {
        width: 0,
        height: 0,
        left: 0,
        top: 0
      }
    };
  },

  components: { Cropper, input_data, yandexMap, ymapMarker },

  methods: {
    crop() {
      const { coordinates, canvas } = this.$refs.cropper.getResult();
      this.coordinates = coordinates;
    },
    onDataSubmit() {
      var self = this;
      axios.post("/api/change_data", this.dataForm).then(
        function(response) {
          console.log(response);
        },
        function(error) {
          console.log(error);
        }
      );
    },
    onPassSubmit() {
      var self = this;
      axios.post("/api/change_pass", this.passForm).then(
        function(response) {
          console.log(response);
        },
        function(error) {
          console.log(error);
        }
      );
    },
    onClick(e) {
      this.mark = e.get("coords");
    },

    onNewImageInput() {
      var reader = new FileReader();
      var self = this;
      reader.onloadend = function() {
        self.image = reader.result;
        console.log(self.image);
      };

      if (this.fileForm.file) {
        reader.readAsDataURL(this.fileForm.file);
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
      forme.append("file", this.fileForm.file);
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
            self.fileForm.file = null;
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
        .post("/api/set_geo", {
          latitude: self.mark[0],
          longitude: self.mark[1]
        })
        .then(
          function(response) {
            console.log(response);
            alert(response.data.answer);
            //self.mark = null;
            self.activeTab = 3;
          },
          function(error) {
            console.log(error);
          }
        );
    },
    onMapDenial() {
      axios
        .post("/api/set_geo", {
          latitude: 9999.0,
          longitude: 9999.0
        })
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
