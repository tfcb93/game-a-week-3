extends Node;

const initial_hungry: float = 1.0;
const initial_money: int = 100;

var money: int = 100;
var hungry: float = 1.0;
var hungry_msg: String = "A little hungry";
var inventory: Array[String] = [];

func _decrease_money(val: int) -> void:
	money -= val;
	Events.emit_signal("update_player_data");
	
func _add_to_inventory(item: String) -> void:
	inventory.push_back(item);
	Events.emit_signal("update_player_data");

func _remove_from_inventory(item: String) -> void:
	var item_index: int = inventory.find(item);
	if (item_index != -1):
		inventory.remove_at(item_index);

func _reduce_hungry(val: float) -> void:
	hungry -= val;
	if (hungry <= 0.0):
		hungry = 0.0;
		get_tree().change_scene_to_file("res://Scenes/end_day.tscn");
	Events.emit_signal("update_player_data");
	
func _another_day() -> void:
	match (Globals.actual_day):
		1:
			hungry = 1.0;
			money += 100;
			hungry_msg = "I need a little snack only";
		2,3,4:
			hungry = 3.0;
			money += 200;
			hungry_msg = "I could eat more than a bite";
		5,6,7:
			hungry = 5.0;
			money += 300;
			hungry_msg = "I'm kinda hungry";
		8,9,10:
			hungry = 7.0;
			money += 400;
			hungry_msg = "hungry";
		11, 12, 13, 14:
			hungry = 10.0;
			money += 500;
			hungry_msg = "I'm very hungry";
		_:
			hungry = 10.0 * floor(Globals.actual_day / 10) + 1;
			money += 500 + ((floor(Globals.actual_day / 10) + 1) * 100);
	inventory = [];

func _reset_player() -> void:
	money = 0;
	_another_day();
	inventory = [];
