
// Add an activity.
Parse.Cloud.define("AddNewActivity", function(request, response) {
  
  var activities = [{
      description:"DigiD",
      accessorName: 'computer',
      flaggedByUser: false,
      city: 'Delft',
      srcDatabase: 'DigiD',
      location: new Parse.GeoPoint(52.016667,4.366667),
      date: new Date(2014, 3, 4, 11, 20)
    },{
      description:"Ingeschreven Den Haag",
      accessorName: 'Gemeente Den Haag',
      flaggedByUser: false,
      city: 'Den Haag',
      srcDatabase: 'GBA,BAG',
      location: new Parse.GeoPoint(52.083333,4.316667),
      date: new Date(2014, 3, 7, 14, 00)
    },{
      description:"Uitgeschreven Delft",
      accessorName: 'Gemeente Den Haag',
      flaggedByUser:false,
      city: 'Den Haag',
      srcDatabase: 'GBA,BAG',
      location: new Parse.GeoPoint(52.083333,4.316667),
      date: new Date(2014, 3, 7, 23, 00)
    },{
      description:"DigiD",
      accessorName: 'computer',
      flaggedByUser: false,
      city: 'Den Haag',
      srcDatabase: 'DigiD',
      location: new Parse.GeoPoint(52.083333,4.316667),
      date: new Date(2014, 4, 2, 14, 00)
    },{
      description:"Aangifte inbraak",
      accessorName: 'Politie',
      flaggedByUser: false,
      city: 'Den Haag',
      srcDatabase: 'GBA,BR,VR',
      location: new Parse.GeoPoint(52.083333,4.316667),
      date: new Date(2014, 4, 2, 14, 00)
    },{
      description:"Paspoort vermist",
      accessorName: 'computer',
      flaggedByUser: false,
      city: 'Den Haag',
      srcDatabase: 'DigiD',
      location: new Parse.GeoPoint(52.083333,4.316667),
      date: new Date(2014, 4, 2, 14, 00)
    },{
      description:"DigiD",
      accessorName: 'computer',
      flaggedByUser: false,
      city: 'Den Haag',
      srcDatabase: 'DigiD',
      location: new Parse.GeoPoint(52.083333,4.316667),
      date: new Date(2014, 4, 2, 14, 00)
    },{
      description:"DigiD",
      accessorName: 'computer',
      flaggedByUser: false,
      city: 'Den Haag',
      srcDatabase: 'DigiD',
      location: new Parse.GeoPoint(52.083333,4.316667),
      date: new Date(2014, 4, 2, 14, 00)
    },{
      description:"DigiD",
      accessorName: 'computer',
      flaggedByUser: false,
      city: 'Den Haag',
      srcDatabase: 'DigiD',
      location: new Parse.GeoPoint(52.083333,4.316667),
      date: new Date(2014, 4, 2, 14, 00)
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







