({
	updateMap : function(component, event, helper) { //Pass the filters as parameters to update map

		var selectedCountryFilter = component.find("selectedOptionsCountries")
				.get("v.value");
		var selectedOptionsCustomerPriorityFilter = component.find(
				"selectedOptionsCustomerPriority").get("v.value");
		var setEvent = component.getEvent("setAttribute");
		setEvent.setParams({
			"countriesData" : selectedCountryFilter,
			"customerPriorityData" : selectedOptionsCustomerPriorityFilter
		});
		setEvent.fire();
	},

	countriesSection : function(component, event, helper) {
		helper.helperMethod(component, event, 'countries');
	},

	customerPrioritySection : function(component, event, helper) {
		helper.helperMethod(component, event, 'customerPriority');
	},

	onSelectionChangedCountries : function(component) {
		var selectCmp = component.find("inputSelectCountries");
		var resultCmp = component.find("selectedOptionsCountries");
		resultCmp.set("v.value", selectCmp.get("v.value"));
	},

	onSelectionChangedCustomerPriority : function(component) {
		var selectCmp = component.find("inputSelectCustomerPriority");
		var resultCmp = component.find("selectedOptionsCustomerPriority");
		resultCmp.set("v.value", selectCmp.get("v.value"));
	}
})