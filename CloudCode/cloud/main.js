

// Add an activity.
Parse.Cloud.define("AddNewActivity", function(request, response) {

  var activities = [{
      description:"Subside aanvraag",
      accessor: 'vYbJ2wR1Vl',
      flaggedByUser: false,
      location: "M1hMxgFDmD",
      src: 'FFzFpAjynb'
    },{
      description:"Adres verandering",
      accessor: vYbJ2wR1Vl,
      flaggedByUser: false,
      location: 'M1hMxgFDmD',
      src: 'W9TNikJ5il'
    },{
      description:"Rekening aanvraag",
      accessor: vYbJ2wR1Vl,
      flaggedByUser: false,
      location: 'M1hMxgFDmD',
      src: 'W9TNikJ5il'
    },{
      description:"ID-bewijs opnieuw aangevraagd",
      accessor: yLb0IwLEk2,
      flaggedByUser: false,
      location: '9Ie05ILjzU',
      src: 'W9TNikJ5il'
  }];

  var Activity = Parse.Object.extend("Activity");
  var act = new Activity();

  var number = int(request.params.number) % activities.length;

  act.save(activities[number], {
    success: function(act) {
      response.success("Created new activity.");
    },
    error: function(act, error) {
      response.error("Failed to create new activity.");
    }
  });
});




