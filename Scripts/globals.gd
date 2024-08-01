extends Node;

const hours = ["23:00", "23:30", "00:00", "00:30", "1:00", "1:30", "2:00", "2:30", "3:00", "3:30", "4:00", "4:30", "5:00", "5:30", "6:00"];
var actual_day: int = 0;
var time: int = 0;
var time_speed: float = 1;
var time_sum: float = 0.0;
var hour_text: String;

var weights: Dictionary = {"🍎": 1.0, "🍌": 1.0, "🧄": 0.1, "🍞": 1.0, "🧀": 1.5, "🥚": 1.5, "🧇": 2.0, "🍖": 3.0, "🍕": 3.0, "🍦": 3.0, "🍰": 4.0, "🍚": 4.0, "🍒": 5.0, "🌽": 6.0, "🍤": 7.0, "🥞": 8.0, "🫑": 9.0, "🌶": 0.5, "🍺": 0.5, "🥦": 1.0, "🥓": 0.1, "🍋‍🟩": 1.0, "🫛": 0.5, "🌮": 3.0, "🥛": 1.5, "🍯": 2.5, "🍹": 0.5, "🍶": 1.5, "🫚": 2.0, "🍵": 1.0, "☕️": 1.0, "🫘": 2.0, "🥒": 1.0, "🍨": 1.5};

func _process(delta: float) -> void:
	time_sum += delta;
	if(time_sum >= time_speed):
		if (time < len(hours) - 1):
			time += 1;
			time_sum = 0.0;
			format_hour();
		else:
			new_day();
		
func format_hour() -> void:
	hour_text = hours[time];
	Events.emit_signal("update_time");
	
func new_day() -> void:
	actual_day += 1;
	time = 0;
	time_sum = 0.0;
	Events.emit_signal("update_day");
	format_hour();
	# other stuff to change for the player and the game after the day passes
	# check if your hunger was filled;
