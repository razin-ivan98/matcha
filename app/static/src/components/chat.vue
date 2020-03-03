<template>
  <div>
    <div class="text-center" v-if="waiting === true">
      <b-spinner
        variant="warning"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        class="mt-5"
      ></b-spinner>
    </div>

    <div v-if="waiting === false">
      <b-container>
        <b-card style="height:calc(100vh - 5rem); flex-direction:unset;">
          <b-card
            :img-src=" '/api/get_avatar?username=' + this.friend.name"
            img-left
            img-width="80"
            img-height="80"
          >
            {{ friend.firstname + ' ' + friend.lastname }}
            <b-card-text style="float:right; ">{{'Был в сети ' + get_online(friend.online) }}</b-card-text>
            <!-- <span
              style="float:right;"
            >{{ mom(chat.last_activity, "DD-MM-YYYY hh:mm:ss") }}</span>-->
          </b-card>

          <b-card ref="win" style=" height: calc(100% - 160px); overflow: auto scroll;">
            <b-card
              border-primary
              v-for="(message, key) in messages"
              :key="key"
              :class="messages.length - unread > key ? 'mt-3 border-success' : 'mt-3 border-warning'"
              :style="message.author === username ? 'width: 80%; float: right;' : 'width: 80%; float: left;'"
              ref="mess"
            >
              {{message.message }}
              <b-card-text
                style="float:right; color: green;"
              >{{ mom(message.date ,"DD-MM-YYYY hh:mm:ss") }}</b-card-text>
            </b-card>
          </b-card>
          <b-card style="height: 80px;">
            <b-form style="display:flex;">
              <b-form-input @keypress="keyPress" type="text" v-model="form.curr_message"></b-form-input>
              <b-button @click="sendMessage();" variant="success">Отправить</b-button>
            </b-form>
          </b-card>
        </b-card>
      </b-container>
    </div>
  </div>
</template>



<script>
import axios from "axios";

import moment from "moment";

export default {
  name: "chat",

  data() {
    return {
      unread: null,
      waiting: true,
      friend: null,
      messages: null,
      form: {
        friend: "",
        curr_message: ""
      }
    };
  },

  computed: {
    username() {
      return this.$route.params.username;
    }
  },

  methods: {
    get_online(str) {
      return moment().unix() - moment(str, "DD-MM-YYYY hh:mm:ss").unix() < 100
        ? "В Сети"
        : moment(str, "DD-MM-YYYY hh:mm:ss").fromNow();
    },
    sendMessage() {
      // console.log(this.form);
      let self = this;
      axios.post("/api/new_message", this.form).then(
        function(response) {
          console.log(response);
          self.form.curr_message = "";
          //  alert(response.data.answer);
        },
        function(error) {
          console.log(error);
        }
      );
    },
    getMessages() {
      let self = this;

      if (self.messages === null) {
        axios
          .get("/api/get_messages?username=" + this.username + "&last=-1")
          .then(function(response) {
            if (response.data.answer === true) {
              self.messages = response.data.messages;
              self.unread = response.data.unread;
              self.$nextTick(() => {
                let mw = self.$refs.mess[self.$refs.mess.length - 1];
                mw.scrollIntoView();
              });
            } else {
              ////////////////////////////////
            }
          });
      } else {
        axios
          .get(
            "/api/get_messages?username=" +
              this.username +
              "&last=" +
              self.messages[self.messages.length - 1].id
          )
          .then(function(response) {
            if (response.data.answer === true) {
              self.messages = self.messages.concat(response.data.messages);
              self.unread = response.data.unread;
              self.$nextTick(() => {
                let mw = self.$refs.mess[self.$refs.mess.length - 1];

                if (
                  self.$refs.win.scrollHeight - self.$refs.win.scrollTop <
                    500 &&
                  response.data.messages.length != 0
                )
                  mw.scrollIntoView();
              });
            } else {
              ////////////////////////////////
            }
          });
      }
    },
    mom(str, pattern) {
      return moment(str, pattern).fromNow();
    },
    keyPress(event) {
      if (event.key == "Enter") {
        event.preventDefault();
        this.sendMessage();
      }
    }
  },
  mounted() {
    moment.locale("ru");

    this.form.friend = this.username;
    let self = this;
    axios.get("/api/get_user_info?username=" + this.username).then(
      function(response) {
        console.log(response.data);
        if (response.data.answer === true) {
          self.friend = response.data.user_info;
          self.waiting = false;
          setInterval(() => {
            self.getMessages();
          }, 2000);
        } else {
        }
      },
      function(error) {
        console.log(error);
      }
    );
  }
};
</script>