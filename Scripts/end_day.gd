extends Control;

@onready var next_day: Button = $"next day";
@onready var day_value: Label = $"information container/day container/day value";
@onready var money_value: Label = $"information container/money container/money value";
@onready var hunger_value: Label = $"information container/hunger container/hunger value";

func _ready() -> void:
	day_value.text = str(Globals.actual_day);
	money_value.text = str(Player.money);
	hunger_value.text = str(Player.hungry);


func _on_next_day_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn");
	Globals.new_day();
