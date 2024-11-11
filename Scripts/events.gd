extends Node;

signal update_player_data();
signal update_time();
signal update_day();
signal show_kitchen();
signal show_games();
signal add_ingredient_to_use(item: String);
signal remove_ingredient_to_use(item: String);
signal cook_food();
signal send_text_to_dialog(text: String);
signal clear_dialog();
signal restart_slots();
signal shuffle_blackjack();
signal check_player_money();
