({
	doInit : function(component, event, helper) {
		var action = component.get("c.getData");
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === "SUCCESS") {
				component.set('v.mapMarkersData', response.getReturnValue());
				component.set('v.markersTitle', 'Account Locations');
				component.set('v.mapCenter', {
					location : {
						Country : 'Germany'
					}
				});
			} else if (state === "ERROR") {
				var errors = response.getError();
				if (errors) {
					if (errors[0] && errors[0].message) {
						console.log("The following error has occured: "
								+ errors[0].message);
					}
				} else {
					console.log("Unknown error");
				}
			}
		});
		$A.enqueueAction(action);
	},

	updateMap : function(component, event, helper) {

		var eventCountriesValue = event.getParam("countriesData");
		var eventCustomerPriorityValue = event.getParam("customerPriorityData");
		var action = component.get("c.updateData");
		action.setParams({
			countries : eventCountriesValue,
			customerPriority : eventCustomerPriorityValue
		});
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === "SUCCESS") {
				component.set("v.mapMarkersData", "");
				component.set('v.mapMarkersData', response.getReturnValue());
			} else if (state === "ERROR") {
				var errors = response.getError();
				if (errors) {
					if (errors[0] && errors[0].message) {
						console.log("The following error has occured: "
								+ errors[0].message);
					}
				} else {
					console.log("Unknown error");
				}
			}
		});
		$A.enqueueAction(action);
	}
})