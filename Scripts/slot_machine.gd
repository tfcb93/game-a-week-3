extends Node2D;

@onready var go: Button = $struct/go;
@onready var reel_1: Sprite2D = $reel_1;
@onready var reel_2: Sprite2D = $reel_2;
@onready var reel_3: Sprite2D = $reel_3;
@onready var result: Label = $struct/result
@onready var award_label: Label = $struct/award

var reel_length: int = 0;
var slots_price: int = 10;

var food: Array[String] = ["🍎", "🍌", "🧄", "🍞", "🧀", "🥚", "🧇", "🍖", "🍕", "🍦", "🍰", "🍚", "🍒", "🌽", "🍤", "🥞", "🫑", "🌶", "🍺", "🥦", "🥓", "🍋‍🟩", "🫛", "🌮", "🥛", "🍯", "🍹", "🍶", "🫚" ,"🍵" , "☕️", "🫘", "🥒", "🍨"];

func _ready() -> void:
	reel_1.frame = 0;
	reel_2.frame = 0; # normally the same as the first one
	reel_3.frame = 0; # normally the same as the first one
	reel_length = reel_1.vframes;
	
	Events.connect("restart_slots", _on_restart_slots);
	Events.connect("check_player_money", _on_check_player_money);

func _on_restart_slots() -> void:
	reel_1.frame = 0;
	reel_2.frame = 0;
	reel_3.frame = 0;


func _on_go_pressed() -> void:
	Player._decrease_money(slots_price);
	Events.emit_signal("check_player_money");
	var one: int = randi_range(0, reel_length - 1);
	var two: int = randi_range(0, reel_length - 1);
	var three: int = randi_range(0, reel_length - 1);
	
	var award: String = "";
	award_label.text = "";
	
	reel_1.frame = one;
	reel_2.frame = two;
	reel_3.frame = three;
	
	if ((one == two or one == three or three == two) and not (one == two and two == three)):
		result.text = "Two are similar!";
		award = food[randi_range(0, one + two + three - 1)];
	elif (one == two and two == three):
		result.text = "JACKPOT!";
		award = food[randi_range(0, one + two + three - 1)];
	else:
		Events.emit_signal("send_text_to_dialog", "Aw dang it!");
	if award != "":
		Events.emit_signal("send_text_to_dialog", "your award is: " + award);
		Player._add_to_inventory(award);
		
func _on_check_player_money() -> void:
	if (Player.money >= slots_price):
		go.disabled = false;
	else:
		go.disabled = true;
