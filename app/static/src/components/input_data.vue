<template>

  <div>
  <b-card title="Sign In" style="max-width: 50rem;" class="mb-2 mt-5 mx-auto">
    <b-form @submit.prevent="onSubmit" v-if="show" >

      </b-container>
      <b-row>
      <b-col>

      <b-form-group id="input-group-2" label="Your FirstName:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.firstname"
          required
          placeholder="Enter your firstname"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-5" label="Your LastName:" label-for="input-5">
        <b-form-input
          id="input-5"
          v-model="form.lastname"
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
          v-model="form.email"
          type="email"
          required
          placeholder="Enter email"
        ></b-form-input>
      </b-form-group>

      </b-col>
      <b-col>

      <b-form-group id="input-group-6" label="Gender:" label-for="input-6">
        <b-form-select
          id="input-6"
          v-model="form.gender"
          :options="genders"
          required
        ></b-form-select>
      </b-form-group>

       <b-form-group id="input-group-7" label="Orientation:" label-for="input-7">
        <b-form-select
          id="input-7"
          v-model="form.orientation"
          :options="orientations"
          required
        ></b-form-select>
      </b-form-group>

      </b-col>
      </b-row>
      </b-container>

      <b-button type="submit" variant="primary">Submit</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
    </b-form>
    </b-card>
  </div>
</template>


<script>

import axios from 'axios'

export default {

  name: 'input_data',

  data() {
      return {
        form: {
          email: '',
          firstname: '',
          lasttname: '',
          gender: null,
          orientation: null,
        },
        genders: [{ text: 'Select One', value: null }, 'Male', 'Female', 'Transgender', 'Teapot'],
        orientations: [{ text: 'Select One', value: null }, 'Natural', 'Bisexual', 'Gomosexual', 'Pidor'],
        show: true
      }
    },
    methods: {
       onSubmit()
        {
            var self = this;
            axios.post('/api/input_data', this.form).then(function (response) {
                console.log(response);
                //alert(response.data.answer);
               /* if (response.data.answer === true)
                    self.$emit('signed-in', response.data.username);
                else
                    self.showAlert();*/
            }, function (error) {
                console.log(error)
                
            })
        },
    },

  computed:{
    username(){
      return this.$store.getters.username;
    }
  },
}
</script>