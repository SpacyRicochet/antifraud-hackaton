// Deze file is van Boris... AFBLIJVEN!

Parse.Cloud.define("NestedActivity", function(request, response) {
	var Activity = Parse.Object.extend("Activity");
	var query = new Parse.Query(Activity);
	query.get(request.params.objectId, {
		success: function(act) {
			response.success(act);
		},
		error: function(act, error) {
			response.error(error);
		}
	});
});

