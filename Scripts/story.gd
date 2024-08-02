extends Node2D;

func _on_button_pressed() -> void:
	Globals.halt_game = false;
	get_tree().change_scene_to_file("res://Scenes/main.tscn");
