extends Control;

@onready var next_day: Button = $"next day";
@onready var day_value: Label = $"information container/day container/day value";
@onready var money_value: Label = $"information container/money container/money value";
@onready var hunger_value: Label = $"information container/hunger container/hunger value";
@onready var big_text: RichTextLabel = $"information container/big_text";

func _ready() -> void:
	big_text.text = big_text.text.replace("DAY_VALUE", str(Globals.actual_day)).replace("MONEY_VALUE", str(Player.money));


func _on_next_day_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn");
	Globals.new_day();
