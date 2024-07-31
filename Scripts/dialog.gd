extends Control;

@onready var text: RichTextLabel = $text

func _ready() -> void:
	Events.connect("send_text_to_dialog", _on_send_text_to_dialog);
	
func _on_send_text_to_dialog(sent_text: String) -> void:
	text.text = sent_text;