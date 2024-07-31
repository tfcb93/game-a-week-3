extends Control

@onready var hungry_value: Label = $HBoxContainer/hungry_value
@onready var clock_value: Label = $HBoxContainer/clock_value
@onready var money_value: Label = $HBoxContainer/money_value

func _ready() -> void:
	money_value.text = str(Player.money);
	hungry_value.text = str(Player.hungry);
	
	Events.connect("update_player_data", _on_update_data);

func _on_update_data() -> void:
	money_value.text = str(Player.money);
	hungry_value.text = str(Player.hungry);
