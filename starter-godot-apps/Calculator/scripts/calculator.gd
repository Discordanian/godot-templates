extends Control

@onready var label = $VBoxContainer/MarginContainer/ResultLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = ""
	for button in $VBoxContainer/PanelContainer/GridContainer.get_children():
		if button is Button:
			button.connect('pressed', button_pressed.bind(button.text))
	%ZeroButton.connect('pressed', button_pressed.bind("0"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func button_pressed(text: String):
	print("button pressed %s" % text)

func _on_zero_button_resized() -> void:
	@warning_ignore("integer_division")
	%ZeroButton.offset_left = -get_window().size.x / 4
