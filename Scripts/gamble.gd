extends Node2D
@onready var slot: Node2D = $Slot
@onready var kitchen: Node2D = $Kitchen
@onready var ui: Control = $Ui

func _ready() -> void:
	kitchen.visible = false;
	Events.connect("show_kitchen", _on_show_kitchen);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;

func _on_show_kitchen() -> void:
	slot.visible = false;
	ui.visible = false;
	kitchen.visible = true;
