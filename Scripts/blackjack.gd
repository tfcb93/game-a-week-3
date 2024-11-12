extends CanvasLayer;

const awards: Array[String] = ["🍞", "🌮", "🥛", "🍯", "🍹", "🍶", "🍨"];
const suits: Array[String] = ["spades", "hearts", "diamonds", "clubs"];
const special_cards: Dictionary = {1: ["Ace", 11], 11: ["Jack", 10], 12: ["Queen", 10], 13: ["King", 10]};
const bj_price: int = 20;

var pile: Array = [];

var table_keep_asking: bool = true;
var is_game_started: bool = false;

func _ready() -> void:
	%interface.visible = true;
	%result.visible = false;
	%player_hand.set_players_name("Player's hand");
	%table_hand.set_players_name("Table's hand");
	Events.connect("shuffle_blackjack", _on_shuffle_blackjack);
	Events.connect("check_player_money", _on_check_player_money);

func _on_shuffle_blackjack() -> void:
	reset_game();

func generate_pile() -> void:
	var cards = range(1, 13);
	for suit in suits:
		for card in cards:
			var selected_card: Array = special_cards.get(card,[str(card), card]);
			pile.push_back([selected_card[0], suit, selected_card[1]]);
	randomize();
	pile.shuffle();

func reset_game() -> void:
	%interface.visible = true;
	%result.visible = false;
	if (Player.money < bj_price):
		%ask.disabled = true;
		%stay.disabled = true;
		Events.emit_signal("send_text_to_dialog", "You don't have money to play this game");
	else:
		%ask.disabled = false;
		%stay.disabled = false;
		generate_pile();
		
	%player_hand.reset_player();
	%table_hand.reset_player();
	table_keep_asking = true;
	is_game_started = false;
	
func _on_restart_pressed() -> void:
	reset_game();

func _on_ask_pressed() -> void:
	if (not is_game_started):
		is_game_started = true;
		Player.decrease_money(bj_price);
		Events.emit_signal("check_player_money");
	var card = pile.pop_front();

	%player_hand.give_card(card);
	
	if (%player_hand.score >= 21):
		%ask.disabled = true;
		%stay.disabled = true;
		if (not table_keep_asking):
			finish_game();
		else:
			keep_playing();
	else:
		ask_table();

func _on_stay_pressed() -> void:
	%ask.disabled = true;
	%stay.disabled = true;
	if (table_keep_asking):
		keep_playing();
	else:
		finish_game();
	
func ask_table() -> void:
	if (table_keep_asking):
		var card = pile.pop_front();
		
		%table_hand.give_card(card);
		
		if (%table_hand.score >= 21):
			table_keep_asking = false;
			finish_game();
		else:
			should_table_keep_asking();

func should_table_keep_asking() -> void:
	if (%table_hand.score > 10 and randi() % 10 + 1 == 1):
		table_keep_asking = false;
	elif (%table_hand.score > 12 and randi() % 8 + 1 == 1):
		table_keep_asking = false;
	elif (%table_hand.score > 15 and randi() % 5 + 1 == 1):
		table_keep_asking = false;
	elif (%table_hand.score > 18 and randi() % 3 + 1 == 1):
		table_keep_asking = false;
	elif (%table_hand.score > 19 and randi() % 2 + 1 == 1):
		table_keep_asking = false;
	
	if (%ask.disabled and not table_keep_asking):
		finish_game();

func keep_playing() -> void:
	while (table_keep_asking):
		ask_table();

func finish_game() -> void:
	%interface.visible = false;
	%result.visible = true;
	
	%match_status.text = "You score was: %d and the table was: %d" % [%player_hand.score, %table_hand.score];
	if (%player_hand.score <= 21 and %table_hand.score <= 21):
		if (%player_hand.score < %table_hand.score):
			%final_result.text = "You lose";
			Player.add_to_inventory(awards[0]);
			Events.emit_signal("send_text_to_dialog", "You got: " + "[emote]" + awards[0] + "[/emote]");
		else:
			%final_result.text = "You win";
			give_award();
	elif(%table_hand.score > 21 and %player_hand.score <= 21):
		%final_result.text = "You win";
		give_award();
	else:
		%final_result.text = "You lose";
		Player.add_to_inventory(awards[0]);
		Events.emit_signal("send_text_to_dialog", "You got: " + "[emote]" + awards[0] + "[/emote]");
	
func _on_check_player_money() -> void:
	if (Player.money >= bj_price):
		%restart.disabled = false;
	else:
		%restart.disabled = true;

func give_award() -> void:
	var award: String;
	if (%player_hand.score < 10):
		award = awards[1];
	elif (%player_hand.score >= 10 and %player_hand.score < 14):
		award = awards[2];
	elif (%player_hand.score >= 14 and %player_hand.score < 17):
		award = awards[3];
	elif (%player_hand.score >= 17 and %player_hand.score < 19):
		award = awards[4];
	elif (%player_hand.score >= 19 and %player_hand.score < 21):
		award = awards[5];
	elif (%player_hand.score == 21):
		award = awards[6];
	Player.add_to_inventory(award);
	Events.emit_signal("send_text_to_dialog", "You got: " + "[emote]" + award + "[/emote]");
