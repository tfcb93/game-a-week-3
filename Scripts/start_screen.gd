extends Node2D;

@onready var canvas: CanvasLayer = $canvas

func _ready() -> void:
	pass;

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/story.tscn");


func _on_quit_pressed() -> void:
	get_tree().quit();
