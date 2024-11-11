extends HBoxContainer;

func change_image(img: String) -> void:
	%image.text = img;

func change_name(new_name: String) -> void:
	%item_name.text = new_name;

func _on_selected_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		Events.emit_signal("add_ingredient_to_use", %image.text);
	else:
		Events.emit_signal("remove_ingredient_to_use", %image.text);
