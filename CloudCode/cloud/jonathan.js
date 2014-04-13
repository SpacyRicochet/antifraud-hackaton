
// Add an activity.
Parse.Cloud.define("AddNewActivity", function(request, response) {
  
  var activities = [{
      description:"Subside aanvraag",
      accessorName: 'Gemeente Den Haag',
      flaggedByUser: false,
      city: 'Den Haag',
      srcDatabase: 'GBA',
      location: new Parse.GeoPoint(52.069694,4.300804),
      date: new Date(2014, 2, 2)
    },{
      description:"Adres verandering",
      accessorName: 'Gemeente Den Haag',
      flaggedByUser: false,
      city: 'Groningen',
      srcDatabase: 'GBA',
      location: new Parse.GeoPoint(52.069694,4.300804),
      date: new Date(2014, 2, 24)
    },{
      description:"Rekening aanvraag",
      accessorName: 'Gemeente Den Haag',
      flaggedByUser:false,
      city: 'Groningen',
      srcDatabase: 'GBA',
      location: new Parse.GeoPoint(52.069694,4.300804),
      date: new Date(2014, 3, 1)
    },{
      description:"ID-bewijs opnieuw aangevraagd",
      accessorName: 'Gemeente Groningen',
      flaggedByUser: false,
      city: 'Groningen',
      srcDatabase: 'GBA',
      location: new Parse.GeoPoint(53.221606,6.563988),
      date: new Date(2014, 3, 5)
  }];

  var Activity = Parse.Object.extend("Activity");
  var act = new Activity();
  var number = 0;
  if(request.params.number !== undefined){
    number = request.params.number;
  }

  act.save(activities[number],{
    success: function(act) {
      response.success("Created new activity.");
    },
    error: function(act, error) {
      response.error(error);
    }
  });
});







