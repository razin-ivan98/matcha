<template>
  <div>
    <b-card
      title="Information about u"
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
                  <b-form-group
                    id="input-group-8"
                    label="Interests:"
                    label-for="input-8"
                  >
                    <b-form-tags
                      input-id="input-8"
                      v-model="interests"
                      class="mb-2"
                    ></b-form-tags>
                  </b-form-group>
                </b-col>
              </b-row>
            </b-container>
            <p>
              <b-button type="submit" variant="primary">Submit</b-button>
              <b-button type="reset" variant="danger">Reset</b-button>
            </p>
          </b-form>
        </b-tab>
        <b-tab title="Bio" :active="this.activeTab === 2">
          <b-form @submit.prevent="onBioSubmit">
            <b-form-group>
              <b-form-textarea
                id="textarea"
                v-model="bioForm.text"
                placeholder="Enter your biography..."
                rows="3"
                max-rows="6"
              ></b-form-textarea>
            </b-form-group>
            <p>
              <b-button type="submit" variant="primary">Submit</b-button>
              <b-button type="reset" variant="danger">Reset</b-button>
            </p>
          </b-form>
        </b-tab>
        <b-tab title="Images" :active="this.activeTab === 3">
          <div>
            <b-container>
              <b-row>
                <b-card
                  v-for="im in images"
                  :key="im.id"
                  :img-src="'/api/download_image?avatar=' + im.url"
                  img-alt="Image"
                  img-top
                  tag="article"
                  style="width: 15rem; display: inline-block"
                  class="mx-auto mb-2"
                >
                  <b-button @click="setAsAvatar(im.id)" variant="primary">
                    Set Avatar
                  </b-button>
                  <b-button @click="deleteImage(im.id)" variant="danger">
                    Delete
                  </b-button>
                </b-card>
              </b-row>
            </b-container>
          </div>
          <b-form
            @submit.prevent="onNewImageSubmit"
            @reset.prevent="onImageReset"
          >
            <b-form-group id="input-group-1">
              <b-form-file
                @input="onNewImageInput"
                v-model="fileForm.file"
                :state="Boolean(fileForm.file)"
                placeholder="Add new Image"
                drop-placeholder="Drop file here..."
              ></b-form-file>
            </b-form-group>

            <b-form-group>
              <b-button type="submit" variant="primary">Submit</b-button>
              <b-button type="reset" variant="danger">Reset</b-button>
            </b-form-group>
          </b-form>

          <clipper-basic
            ref="clipper"
            v-if="this.image != null"
            :src="this.image"
            :ratio="1"
          ></clipper-basic>
        </b-tab>
        <b-tab title="Map" :active="this.activeTab === 4">
          <div>
            <yandex-map
              style="width: 100%; height: 50vh; margin-bottom:10px;"
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
              ></ymap-marker>
            </yandex-map>
          </div>
          <p>
            <b-button @click="onMapSubmit" variant="primary">Submit</b-button>
            <b-button @click="onMapDenial" variant="warning">Не скажу</b-button>
          </p>
        </b-tab>
        <b-tab title="Password" :active="this.activeTab === 5">
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
        </b-tab>
      </b-tabs>
      <p>
        <b-button @click="endRegistration">
          End Registration
        </b-button>
      </p>
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
import { clipperBasic } from "vuejs-clipper";
import { yandexMap, ymapMarker } from "vue-yandex-maps";

export default {
  name: "input_data",

  data() {
    return {
      variant: "danger",
      dismissSecs: 5,
      dismissCountDown: 0,
      showDismissibleAlert: false,
      text: "",

      activeTab: 1,

      mark: this.store_coords,
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
      interests: this.$store.getters.user_info.interests,
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
      bioForm: {
        text: this.$store.getters.user_info.biography
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
  components: { clipperBasic, yandexMap, ymapMarker },

  computed: {
    images() {
      return this.$store.getters.user_info.images;
    },
    store_coords() {
      return [
        this.$store.getters.user_info.latitude,
        this.$store.getters.user_info.longitude
      ];
    }
  },
  methods: {
    onDataSubmit() {
      var self = this;
      const frm = { ...this.dataForm };
      frm.interests = JSON.stringify(this.interests);
      axios.post("/api/input_data", frm).then(
        function(response) {
          if (response.data.answer) self.showAlert("success", "Success");
          else self.showAlert("danger", "Error");
        },
        function(error) {
          self.showAlert("danger", "Error");
        }
      );
    },
    onBioSubmit() {
      var self = this;
      axios.post("/api/change_bio", this.bioForm).then(
        function(response) {
          if (response.data.answer) self.showAlert("success", "Success");
          else self.showAlert("danger", "Error");
        },
        function(error) {
          self.showAlert("danger", "Error");
        }
      );
    },
    onPassSubmit() {
      var self = this;
      axios.post("/api/change_pass", this.passForm).then(
        function(response) {
          if (response.data.answer) self.showAlert("success", "Success");
          else self.showAlert("danger", "Error");
        },
        function(error) {
          self.showAlert("danger", "Error");
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
      };

      if (this.fileForm.file) {
        reader.readAsDataURL(this.fileForm.file);
      } else {
        this.image = "";
      }
    },
    onImageReset() {
      this.fileForm.file = null;
      this.image = null;
    },

    deleteImage(id) {
      const self = this;
      axios.get("/api/delete_image?id=" + id).then(
        function(response) {
          self.$store.dispatch("isSigned");
          if (response.data.answer) self.showAlert("success", "Success");
          else self.showAlert("danger", "Error");
        },
        function(error) {
          self.showAlert("danger", "Error");
        }
      );
    },
    setAsAvatar(id) {
      axios.get("/api/set_avatar?id=" + id).then(
        function(response) {
          if (response.data.answer) self.showAlert("success", "Success");
          else self.showAlert("danger", "Error");
        },
        function(error) {
          self.showAlert("danger", "Error");
        }
      );
    },

    onNewImageSubmit() {
      const self = this;

      const data = this.$refs.clipper.getDrawPos().pos;

      this.coordinates = {
        width: data.dwidth,
        height: data.dheight,
        left: data.sx,
        top: data.sy
      };

      var forme = new FormData();
      forme.append("file", this.fileForm.file);
      forme.append("coordinates", JSON.stringify(this.coordinates));

      axios
        .post("/api/upload_image", forme, {
          headers: {
            "Content-Type": "multipart/form-data"
          }
        })
        .then(
          function(response) {
            if (response.data.answer) self.showAlert("success", "Success");
            else self.showAlert("danger", "Error");
            self.onImageReset();
            self.$store.dispatch("isSigned");
          },
          function(error) {
            self.showAlert("danger", "Error");
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
            if (response.data.answer) self.showAlert("success", "Success");
            else self.showAlert("danger", "Error");
          },
          function(error) {
            self.showAlert("danger", "Error");
          }
        );
    },
    onMapDenial() {
      const self = this;
      axios
        .post("/api/set_geo", {
          latitude: 9999.0,
          longitude: 9999.0
        })
        .then(
          function(response) {
            if (response.data.answer) {
              self.showAlert("success", "Success");
              self.$store.dispatch("isSigned");
              self.mark = self.store_coords;
            } else self.showAlert("danger", "Error");
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
    },
    endRegistration() {
      const self = this;
      axios.get("/api/end_registration").then(
        function(response) {
          if (response.data.answer) {
            self.showAlert("success", "Success");
            self.$router.push("/");
          } else self.showAlert("danger", "Error");
        },
        function(error) {
          self.showAlert("danger", "Error");
        }
      );
    }
  }
};
</script>
