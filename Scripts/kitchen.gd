extends Node2D;

var item: PackedScene = preload("res://Scenes/kitchen_item.tscn");
@onready var ingredients: VBoxContainer = $interface/ingredients;
@onready var cook: Button = $cook;

var selected_ingredients: Array[String] = [];

func _ready() -> void:
	Events.connect("show_kitchen", build_ingredients_list);
	Events.connect("add_ingredient_to_use", _on_add_ingredient_to_use);
	Events.connect("remove_ingredient_to_use", _on_remove_ingredient_to_use);

func build_ingredients_list() -> void:
	for ingredient in Player.inventory:
		var new_item = item.instantiate();
		ingredients.add_child(new_item);
		new_item.change_image(ingredient);

func clear_ingredient_list() -> void:
	for child in ingredients.get_children():
		ingredients.remove_child(child);
		child.queue_free();

func _on_add_ingredient_to_use(ingredient: String) -> void:
	selected_ingredients.push_back(ingredient);

func _on_remove_ingredient_to_use(ingredient: String) -> void:
	var ingredient_pos: int = selected_ingredients.find(ingredient);
	if (ingredient_pos != -1):
		selected_ingredients.remove_at(ingredient_pos);

func _on_cook_pressed() -> void:
	var total: float = 0.0;
	var food_text: String = "Chef made a plate with: ";
	print(", ".join(selected_ingredients));
	for ingredient in selected_ingredients:
		total += Globals.weights[ingredient];
		Player._remove_from_inventory(ingredient);
		food_text += ingredient;
	food_text += ", and it sasiate you in " + str(total) + ". It was delicious!";
	print(food_text);
	Player._reduce_hungry(total);
	clear_ingredient_list();
	if (len(Player.inventory) > 0):
		build_ingredients_list();
	else:
		print("You have no more ingredients");
		cook.disabled = true;
