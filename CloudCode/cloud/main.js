
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("AddNewActivity", function(request, response) {
  var Activity = Parse.Object.extend("Activity");
  var act = new Activity();
   
  act.set("description", "Uitschrijving bij gemeente");
   
  act.save(null, {
    success: function(act) {
      response.success("Created new activity.");
    },
    error: function(act, error) {
      response.error("Failed to create new activity.");
    }
  });
});


//   Parse.Cloud.AfterSaveRequest()

//   Parse.Push.send({
//     channels: ["Activities"],
//     expiration_time: new Date(2014, 4, 17),
//     data: {
//       alert: "Hello all!"
//     }
//   }, {
//     success: function() {
//       response.success("Hello world!");
//     },
//     error: function(error) {
//       response.error("Bye world!");
//     }
//   });
// });

Parse.Cloud.afterSave('Activity', function(request) {
  today = new Date();
  Parse.Push.send({
    channels: ["Activities"],
    expiration_time: new Date().setDate(today.getDate()+7), // after 7 days
    data: {
      alert: request.object.get('description'),
      object: request.object.get('objectId')
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

