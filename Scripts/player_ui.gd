extends Control;

func _ready() -> void:
	_on_update_data();
	_on_update_day();
	
	Events.connect("update_player_data", _on_update_data);
	Events.connect("update_time", _on_update_time);
	Events.connect("update_day", _on_update_day);

func _on_update_data() -> void:
	%money_value.text = str(Player.money);
	%hungry_value.text = str(Player.hungry);
	%hungry_msg.text = " (" + Player.hungry_msg + ")";

func _on_update_time() -> void:
	%clock_value.text = Globals.hour_text;

func _on_update_day() -> void:
	%day_value.text = str(Globals.actual_day);
