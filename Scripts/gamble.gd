extends Node2D
@onready var slots: Node2D = $Slots;
@onready var blackjack: Node2D = $Blackjack;
@onready var return_btn: Button = $interface/return;
@onready var selection: VBoxContainer = $interface/selection;

@export_enum("kitchen", "selection") var button_type: String = "kitchen";

func _ready() -> void:
	slots.visible = false;
	blackjack.visible = false;
	selection.visible = true;
	return_btn.visible = true;
	return_btn.text = "Go to the kitchen";
	button_type = "kitchen";
	Events.connect("show_games", _on_show_games);
	Events.connect("show_kitchen",_on_show_kitchen);

func _on_show_games() -> void:
	slots.visible = false;
	blackjack.visible = false;
	selection.visible = true;
	return_btn.visible = true;
	return_btn.text = "Go to the kitchen";
	button_type = "kitchen";

func _on_show_kitchen() -> void:
	slots.visible = false;
	blackjack.visible = false;
	selection.visible = false;
	return_btn.visible = false;

func _on_slots_pressed() -> void:
	slots.visible = true;
	blackjack.visible = false;
	selection.visible = false;
	Events.emit_signal("restart_slots");
	return_btn.text = "Return to selection";
	button_type = "selection";


func _on_return_pressed() -> void:
	if (button_type == "kitchen"):
		Events.emit_signal("show_kitchen");
	else:
		_on_show_games();


func _on_blackjack_pressed() -> void:
	slots.visible = false;
	selection.visible = false;
	blackjack.visible = true;
	Events.emit_signal("shuffle_blackjack");
