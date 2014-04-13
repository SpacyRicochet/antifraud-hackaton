Parse.Cloud.afterSave('Activity', function(request) {
  today = new Date();
  Parse.Push.send({
    channels: ["Activities"],
    expiration_time: new Date(2014, 4, 17),
    data: {
      alert: "Uw identiteit is gebruikt voor '" + request.object.get("description") + "'. Klopt dit?"
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
