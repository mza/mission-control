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