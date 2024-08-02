extends Control

@onready var end_text: RichTextLabel = $end_text
@onready var restart: Button = $VBoxContainer/restart
@onready var quit: Button = $VBoxContainer/quit

func _ready() -> void:
	end_text.text = end_text.text.replace("DAY_VALUE", str(Globals.actual_day)).replace("HUNGER_VALUE", str(Player.hungry));

func _on_restart_pressed() -> void:
	# remeber to reset player and global values, and check if you need to reset games too
	get_tree().change_scene_to_file("res://Scenes/story.tscn");


func _on_quit_pressed() -> void:
	get_tree().quit();