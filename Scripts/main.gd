extends Node2D;

@onready var gamble: Node2D = $screens/Gamble;
@onready var kitchen: Node2D = $screens/Kitchen;

func _ready() -> void:
	pass;


func _on_go_back_pressed() -> void:
	Globals.check_game_progress();
