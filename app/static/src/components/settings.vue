<template>
    <div>
        <b-card title="Settings" style="max-width: 50rem;" class="mb-2 mt-5 mx-auto">
            <b-form @submit.prevent="onSubmit">

                 <b-form-group
                    id="input-group-1">
                    <b-form-file
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
        </b-card>
    </div>
</template>

<script>

import axios from 'axios'

export default {
    data() {
      return {
          form: {
              file: null
          }
      }
    },

    methods: {
        onSubmit(){
            var forme = new FormData();
            forme.append('file', this.form.file);
               // alert(this.form.file);
            axios.post('/api/upload_image', forme, 
                {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }}).then(function (response) {
                console.log(response);
                alert(response.data.answer)
            }, function (error) {
                console.log(error)
            })
        }
    }
}
</script>