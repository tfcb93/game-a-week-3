extends Node;

var money: int = 100;
var hungry: float = 10.0;
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
	if (hungry < 0):
		hungry = 0.0;
	Events.emit_signal("update_player_data");
