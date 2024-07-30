extends Control
@onready var money: Label = $PlayerData/Money
@onready var inventory: Label = $PlayerData/Inventory

func _ready() -> void:
	money.text = str(Player.money);
	inventory.text = str(", ".join(Player.inventory));
	Events.connect("update_player_data", _on_update_player_data);

func _on_update_player_data() -> void:
	money.text = str(Player.money);
	inventory.text = str(", ".join(Player.inventory));
