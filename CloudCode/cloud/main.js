
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {


  Parse.Push.send({
    channels: ["Activities"],
    expiration_time: new Date(2014, 4, 17),
    data: {
      alert: "Hello all!"
    }
  }, {
    success: function() {
      response.success("Hello world!");
    },
    error: function(error) {
      response.error("Bye world!");
    }
  });
});
