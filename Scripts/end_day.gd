extends Control;


func _ready() -> void:
	%big_text.text = %big_text.text.replace("DAY_VALUE", str(Globals.actual_day)).replace("MONEY_VALUE", str(Player.money));


func _on_next_day_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn");
	Globals.new_day();
