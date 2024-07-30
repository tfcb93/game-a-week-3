extends Node2D;

@onready var go: Button = $struct/go;
@onready var reel_1: Label = $struct/reels/reel_1;
@onready var reel_2: Label = $struct/reels/reel_2;
@onready var reel_3: Label = $struct/reels/reel_3;
@onready var result: Label = $struct/result

var reel_values: Array[String] = ["🦴", "🧠", "🧶", "🪭", "🤘🏻", "🦞", "⚡️", "🌞"];
@onready var award_label: Label = $struct/award


var food: Array[String] = ["🍎", "🍌", "🧄", "🍞", "🧀", "🥚", "🧇", "🍖", "🍕", "🍦", "🍰", "🍚", "🍒", "🌽", "🍤", "🥞", "🫑", "🌶", "🍺", "🥦", "🥓"];

func _ready() -> void:
	reel_1.text = "Let's";
	reel_2.text = "Go";
	reel_3.text = "Gambling!";

func _process(delta: float) -> void:
	pass


func _on_go_pressed() -> void:
	Player._decrease_money(10);
	if (Player.money <= 0):
		go.disabled = true;
		Events.emit_signal("show_kitchen");
	var one: int = randi_range(0, len(reel_values) - 1);
	var two: int = randi_range(0, len(reel_values) - 1);
	var three: int = randi_range(0, len(reel_values) - 1);
	
	var award: String = "";
	award_label.text = "";
	
	reel_1.text = reel_values[one];
	reel_2.text = reel_values[two];
	reel_3.text = reel_values[three];
	
	if ((one == two or one == three or three == two) and not (one == two and two == three)):
		result.text = "Two are similar!";
		award = food[randi_range(0, one + two + three - 1)];
	elif (one == two and two == three):
		result.text = "JACKPOT!";
		award = food[randi_range(0, one + two + three - 1)];
	else:
		result.text = "Aw dang it!"
	if award != "":
		award_label.text = "your award is: " + award;
		Player._add_to_inventory(award);
		
