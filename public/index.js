/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {};
  },
  created: function() {
    console.log("home");
  }
};

var UserPage = {
  template: "#user-page",
  data: function() {
    return {
      currentUser: {}
    };
  },
  created: function() {
    axios.get("/users" + this.$route.params.id).then(
      function(response) {
        this.users = response.data;
      }.bind(this)
    );
  }
};

var ShowPage = {
  template: "#show-page",
  data: function() {
    return {
      dogs: []
    };
  },
  created: function() {
    axios.get("/dogs").then(
      function(response) {
        this.dogs = response.data;
      }.bind(this)
    );
  }
};

var SearchPage = {
  template: "#search-page",
  data: function() {
    return {
      dogs: []
    };
  },
  created: function() {
    axios.get("/dogs/" + this.$route.params.id).then(
      function(response) {
        this.dog = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/user", component: UserPage },
    { path: "/show", component: ShowPage }
  ]
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
