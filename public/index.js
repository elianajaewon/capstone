/* global Vue, VueRouter, axios, initTheme */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {};
  },
  created: function() {
    console.log("home");
  },
  mounted: function() {
    initTheme();
  }
};

var UserPage = {
  template: "#user-page",
  data: function() {
    return {
      user: "",
      randomDogs: []
    };
  },
  created: function() {
    axios.get("/users/" + this.$route.params.id).then(
      function(response) {
        console.log("users page:", "/users/" + this.$route.params.id, response);
        this.user = response.data["message"];
        this.randomDogs = this.user.dogs
          .slice()
          .sort(function() {
            return 0.5 - Math.random();
          })
          .slice(0, 3);
        console.log(response.data);
      }.bind(this)
    );
  },
  mounted: function() {
    initTheme();
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
        this.dogs = response.data.sort(function(a, b) {
          if (a.breed < b.breed) return -1;
          if (a.breed > b.breed) return 1;
          return 0;
        });
        console.log(this.dogs);
        console.log(response.data);
      }.bind(this)
    );
  },
  mounted: function() {
    initTheme();
  }
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
  },
  mounted: function() {
    initTheme();
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
        })
        .then(function(response) {
          router.push("/survey/me");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  },
  mounted: function() {
    initTheme();
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var SurveyPage = {
  template: "#survey-page",
  data: function() {
    return {
      zipCode: "",
      workHours: "",
      homeType: "",
      allergies: "",
      noiseLevel: "",
      kids: "",
      pets: "",
      activityLevel: "",
      errors: []
    };
  },
  created: function() {
    axios.get("/users/" + this.$route.params.id).then(
      function(response) {
        (this.zipCode = response.data.message.zip_code),
          (this.workHours = response.data.message.work_hours),
          (this.homeType = response.data.message.home_type),
          (this.allergies = response.data.message.allergies),
          (this.noiseLevel = response.data.message.noise_level),
          (this.kids = response.data.message.kids),
          (this.pets = response.data.message.pets),
          (this.activityLevel = response.data.message.activity_level);
      }.bind(this)
    );
  },
  methods: {
    submit: function() {
      var params = {
        zip_code: this.zipCode,
        work_hours: this.workHours,
        home_type: this.homeType,
        allergies: this.allergies,
        noise_level: this.noiseLevel,
        kids: this.kids,
        pets: this.pets,
        activity_level: this.activityLevel
      };
      axios
        .patch("/users/" + this.$route.params.id, params)
        .then(function(response) {
          router.push("/users/me");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  },
  mounted: function() {
    initTheme();
  }
};

var PetfinderPage = {
  template: "#petfinder-page",
  data: function() {
    return {
      matches: [],
      errorMessage: ""
    };
  },
  created: function() {
    axios.get("/matches/" + this.$route.params.id).then(
      function(response) {
        var data = [];
        console.log(
          "gonna loop",
          response.data.petfinder.pets,
          response.data.petfinder.pets.pet
        );
        if (response.data.petfinder.pets.pet) {
          response.data.petfinder.pets.pet.forEach(function(pet) {
            var info = {};
            info.name = pet.name.$t;
            info.breed = pet.breeds.breed.$t;
            info.sex = pet.sex.$t;
            info.age = pet.age.$t;
            info.description = pet.description.$t;
            info.email = pet.contact.email.$t;
            info.city = pet.contact.city.$t;
            info.state = pet.contact.state.$t;
            if (pet.media.photos) {
              info.photo = pet.media.photos.photo[2].$t;
            } else {
              info.photo = "assets/images/filler.jpg";
            }
            data.push(info);
          });
          this.matches = data;
        } else {
          this.errorMessage = "No matches found!";
        }
      }.bind(this)
    );
  },
  mounted: function() {
    initTheme();
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/users/:id", component: UserPage },
    { path: "/show", component: ShowPage },
    { path: "/survey/:id", component: SurveyPage },
    { path: "/matches/:id", component: PetfinderPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
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
