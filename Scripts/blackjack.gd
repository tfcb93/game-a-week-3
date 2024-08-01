extends CanvasLayer;

var suits: Array[String] = ["spades", "hearts", "diamonds", "clubs"];
var pile: Array = [];
var players_hand: Array = [];
var tables_hand: Array = [];
var player_total_score: int = 0;
var table_total_score: int = 0;
var table_keep_asking: bool = true;

@onready var interface: VBoxContainer = $interface;
@onready var result: VBoxContainer = $result;


@onready var ask: Button = $interface/buttons/ask;
@onready var stay: Button = $interface/buttons/stay;

@onready var hand: VBoxContainer = $interface/text/hand/players_hand;
@onready var table: VBoxContainer = $interface/text/table/tables_hand;

@onready var player_score: Label = $interface/text/hand/player_score;
@onready var table_score: Label = $interface/text/table/table_score;

@onready var final_result: Label = $result/result;
@onready var match_status: Label = $result/match_status;


func _ready() -> void:
	interface.visible = true;
	result.visible = false;
	Events.connect("shuffle_blackjack", _on_shuffle_blackjack);
	reset_game();

func _process(delta: float) -> void:
	pass

func _on_shuffle_blackjack() -> void:
	reset_game();

func generate_pile() -> void:
	var cards = range(1, 13);
	for suit in suits:
		for card in cards:
			var points: int;
			var card_name: String;
			match(card):
				1:
					points = 11;
					card_name = "Ace"
				11:
					points = 10;
					card_name = "Jack";
				12:
					points = 10;
					card_name = "Queen";
				13:
					points = 10;
					card_name = "King";
				_:
					points = card;
					card_name = str(card);
			pile.push_back([card_name, suit, points]);
	randomize();
	pile.shuffle();

func reset_game() -> void:
	players_hand = [];
	tables_hand = [];
	reset_hands();
	player_total_score = 0;
	table_total_score = 0;
	ask.disabled = false;
	stay.disabled = false;
	player_score.text = str(player_total_score);
	table_score.text = str(table_total_score);
	table_keep_asking = true;
	generate_pile();
	
func reset_hands() -> void:
	for card in hand.get_children():
		hand.remove_child(card);
		card.queue_free();
	for card in table.get_children():
		table.remove_child(card);
		card.queue_free();

func _on_restart_pressed() -> void:
	interface.visible = true;
	result.visible = false;
	reset_game();

func _on_ask_pressed() -> void:
	var card = pile.pop_front();
	if (card[0] == "Ace" and card[2] + player_total_score > 21):
		card[2] = 1;
	players_hand.push_back(card);
	player_total_score += card[2];
	
	player_score.text = str(player_total_score);
	var label = Label.new();
	label.text = card[0] + " of " + card[1] + ': ' + str(card[2]);
	label.horizontal_alignment = 2;
	hand.add_child(label);
	
	if (player_total_score >= 21):
		ask.disabled = true;
		stay.disabled = true;
		if (not table_keep_asking):
			finish_game();
		else:
			keep_playing();
	else:
		ask_table();
	

func _on_stay_pressed() -> void:
	ask.disabled = true;
	stay.disabled = true;
	if (table_keep_asking):
		keep_playing();
	else:
		finish_game();
	
func ask_table() -> void:
	if (table_keep_asking):
		var card = pile.pop_front();
		if (card[0] == "Ace" and card[2] + table_total_score > 21):
			card[2] = 1;
		tables_hand.push_back(card);
		table_total_score += card[2];
			
		table_score.text = str(table_total_score);
		var label = Label.new();
		label.text = card[0] + " of " + card[1] + ': ' + str(card[2]);
		table.add_child(label);
		
		if (table_total_score >= 21):
			table_keep_asking = false;
			if (ask.disabled):
				finish_game();
		else:
			should_table_keep_asking();

func should_table_keep_asking() -> void:
	if (table_total_score > 10 and randi() % 10 + 1 == 1):
		table_keep_asking = false;
	elif (table_total_score > 12 and randi() % 8 + 1 == 1):
		table_keep_asking = false;
	elif (table_total_score > 15 and randi() % 5 + 1 == 1):
		table_keep_asking = false;
	elif (table_total_score > 18 and randi() % 3 + 1 == 1):
		table_keep_asking = false;
	elif (table_total_score > 19 and randi() % 2 + 1 == 1):
		table_keep_asking = false;
	
	if (ask.disabled and not table_keep_asking):
		finish_game();

func keep_playing() -> void:
	while (table_keep_asking):
		ask_table();

func finish_game() -> void:
	interface.visible = false;
	result.visible = true;
	
	match_status.text = "You score was: %d and the table was: %d" % [player_total_score, table_total_score];
	if (player_total_score <= 21 and table_total_score <= 21):
		if (player_total_score < table_total_score):
			final_result.text = "You lose";
		else:
			final_result.text = "You win";
	elif(table_total_score > 21 and player_total_score <= 21):
		final_result.text = "You win";
	else:
		final_result.text = "You lose";
	
	# show button to restart game
	# give player stuff

