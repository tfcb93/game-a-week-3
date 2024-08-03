extends CanvasLayer;

@onready var go: Button = $organize/struct/go;
@onready var result: Label = $organize/struct/result
@onready var award_label: Label = $organize/struct/award

@onready var reel_1: TextureRect = $organize/reels/reel_1;
@onready var reel_2: TextureRect = $organize/reels/reel_2;
@onready var reel_3: TextureRect = $organize/reels/reel_3;

var reel_length: int = 704 / 64; # image size; Yes, I put it manually for now
var slots_price: int = 10;

var food: Array[String] = ["🍎", "🍌", "🧄", "🍞", "🧀", "🥚", "🧇", "🍖", "🍕", "🍦", "🍰", "🍚", "🍒", "🌽", "🍤", "🥞", "🫑", "🌶", "🍺", "🥦", "🥓", "🍋‍🟩", "🫛", "🌮", "🥛", "🍯", "🍹", "🍶", "🫚" ,"🍵" , "☕️", "🫘", "🥒", "🍨"];

func _ready() -> void:
	reel_1.texture.region.position.y = 0;
	reel_2.texture.region.position.y = 0; # normally the same as the first one
	reel_3.texture.region.position.y = 0; # normally the same as the first one
	
	Events.connect("restart_slots", _on_restart_slots);
	Events.connect("check_player_money", _on_check_player_money);
	

func _on_restart_slots() -> void:
	reel_1.texture.region.position.y = 0;
	reel_2.texture.region.position.y = 0;
	reel_3.texture.region.position.y = 0;


func _on_go_pressed() -> void:
	result.text = "";
	Player._decrease_money(slots_price);
	Events.emit_signal("check_player_money");
	var one: int = randi_range(0, reel_length - 1);
	var two: int = randi_range(0, reel_length - 1);
	var three: int = randi_range(0, reel_length - 1);
	
	var award: String = "";
	award_label.text = "";
	
	reel_1.texture.region.position.y = reel_1.texture.region.size.y * one;
	reel_2.texture.region.position.y = reel_2.texture.region.size.y * two;
	reel_3.texture.region.position.y = reel_3.texture.region.size.y * three;
	
	if ((one == two or one == three or three == two) and not (one == two and two == three)):
		result.text = "Two are similar!";
		award = food[randi_range(0, one + two + three - 1)];
	elif (one == two and two == three):
		result.text = "JACKPOT!";
		award = food[randi_range(0, one + two + three - 1)];
	else:
		Events.emit_signal("send_text_to_dialog", "Aw dang it!");
	if award != "":
		Events.emit_signal("send_text_to_dialog", "your award is: " + "[emote]" + award + "[/emote]");
		Player._add_to_inventory(award);
		
func _on_check_player_money() -> void:
	if (Player.money >= slots_price):
		go.disabled = false;
	else:
		go.disabled = true;
