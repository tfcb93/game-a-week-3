extends Node2D;

var button_type: Globals.return_btn_types = Globals.return_btn_types.KITCHEN;

func _ready() -> void:
	set_screen_item_visibility(true, false, false);
	set_return_button_to_kitchen();

	Events.connect("show_games", _on_show_games);
	Events.connect("show_kitchen",_on_show_kitchen);

func _on_show_games() -> void:
	set_screen_item_visibility(true, false, false);

	set_return_button_to_kitchen();

func _on_show_kitchen() -> void:
	set_screen_item_visibility(false, false, false);
	%btn_return.visible = false;

func _on_slots_pressed() -> void:
	set_screen_item_visibility(false, false, true);
	set_return_button_to_selection();
	Events.emit_signal("restart_slots");

func _on_return_pressed() -> void:
	if (button_type == Globals.return_btn_types.KITCHEN):
		Events.emit_signal("show_kitchen");
	else:
		_on_show_games();

func _on_blackjack_pressed() -> void:
	set_screen_item_visibility(false, true, false);
	Events.emit_signal("shuffle_blackjack");
	
	set_return_button_to_selection();

func set_screen_item_visibility(selection_visibility: bool, blackjack_visibility: bool, slots_visibility: bool) -> void:
	%selection.visible = selection_visibility;
	%slots.visible = slots_visibility;
	%blackjack.visible = blackjack_visibility;

func set_return_button_to_selection() -> void:
	%btn_return.visible = true;
	%btn_return.text = "Return to selection";
	button_type = Globals.return_btn_types.SELECTION;

func set_return_button_to_kitchen() -> void:
	%btn_return.visible = true;
	%btn_return.text = "Go to the kitchen";
	button_type = Globals.return_btn_types.KITCHEN;
