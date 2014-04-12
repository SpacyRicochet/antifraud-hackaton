// Deze file is van Boris... AFBLIJVEN!

Parse.Cloud.define("NestedActivity", function(request, response) {
	var Activity = Parse.Object.extend("Activity");
	var query = new Parse.Query(Activity);
	query.equalTo("objectId", request.params.objectId);
	query.first({
		success: function(act) {
			response.success(act);
		},
		error: function(act, error) {
			response.error("Problem");
		}
	});
});

