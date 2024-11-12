extends VBoxContainer;

@export_category("Blackjack Player")

var hand: Array = [];
var score: int = 0;

func _ready() -> void:
	update_score_label();

func set_players_name(given_name: String) -> void:
	%player_name.text = given_name;

func reset_player() -> void:
	hand = [];
	score = 0;
	update_score_label();
	for label in %player_hand.get_children():
		%player_hand.remove_child(label);
		label.queue_free();

func give_card(card: Array) -> void:
	# Checks if the score will be higher than 21 if you sum the ace value
	if (card[0] == "Ace" and card[2] + score > 21):
		card[2] = 1;
	hand.push_back(card);
	score += card[2];
	
	update_score_label();
	var label = Label.new();
	label.text = card[0] + " of " + card[1] + ': ' + str(card[2]);
	label.horizontal_alignment = 2;
	%player_hand.add_child(label);
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;

func update_score_label() -> void:
	%player_score.text = str(score);