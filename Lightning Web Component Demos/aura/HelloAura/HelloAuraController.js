({
	count: function (component, event, helper) {
		var greeting = component.get("v.greeting");
		alert(greeting.length + " letters");
	}
})