Parse.Cloud.afterSave('Activity', function(request) {
  today = new Date();
  Parse.Push.send({
    channels: ["Activities"],
    expiration_time: new Date(2014, 4, 17),
    data: {
      alert: request.object.id
    }
  }, {
    success: function() {
      //response.success("Hello world!");
    },
    error: function(error) {
      //response.error("Bye world!");
    }
  });
});
