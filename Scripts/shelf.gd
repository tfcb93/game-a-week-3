extends VBoxContainer;

var item: PackedScene = preload("res://Scenes/kitchen_item.tscn");

func _ready() -> void:
	Events.connect("show_kitchen", build_ingredients_list);


func build_ingredients_list() -> void:
	for ingredient in Player.inventory:
		var new_item = item.instantiate();
		self.add_child(new_item);
		new_item.change_image(ingredient);
