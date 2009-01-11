function add_to_select(source, target) {
	
	var option = null;
	
	$$("#" + source + " option").each(function(element) {
		if (element.selected == true) {
			option = element
		}
	});
	
	position = $$("#" + target + " option").length;
    $(target).options.add(option, position);
}

function submit_instance(name, specification) {
	// $$("#" + specification + " option").each(function(element) {
	// 		option = element
	// });
	
	new Ajax.Request('/instances/create', { method:'post',
	  parameters: $(specification).serialize(true)
	});
	
}