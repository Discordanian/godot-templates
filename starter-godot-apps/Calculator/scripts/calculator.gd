extends Control

@onready var label = $VBoxContainer/MarginContainer/ResultLabel
var temp_nums: Array[String] = []
var fin_nums: Array[String] = []


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
	if text.is_valid_int():
		temp_nums.append(text)
		print(temp_nums)
		print("%s" % text)
		label.text = "".join(temp_nums)
	else:
		non_number_button_pressed(text)

func non_number_button_pressed(text: String):
	if text in ["+", "-", "*", "/"]:
		fin_nums.append("".join(temp_nums))
		fin_nums.append(text)
		print(fin_nums)
		temp_nums.clear()
		label.text = "".join(temp_nums)

	if text == "=":
		fin_nums.append("".join(temp_nums))
		print(fin_nums)
		var expression = Expression.new()
		expression.parse("".join(fin_nums))
		var result = expression.execute()
		label.text = str(result)
		fin_nums.clear()
		temp_nums.clear()
		temp_nums.append(str(result))

	if text == "C":
		temp_nums.clear()
		fin_nums.clear()
		label.text = ""

	if text == ".":
		if not "." in temp_nums:
			temp_nums.append(".")
			label.text = "".join(temp_nums)

	if text == "+/-":
		if temp_nums:
			temp_nums[0] = str(-int(temp_nums[0]))
			label.text = "".join(temp_nums)
		else:
			fin_nums[0] = str(-int(fin_nums[0]))
			label.text = "".join(fin_nums)

	if text == "%":
		var num = float("".join(temp_nums)) * 0.01
		temp_nums.clear()
		temp_nums.append(str(num))
		label.text = "".join(temp_nums)

	if text == "=":
		var expression = Expression.new()
		expression.parse("".join(fin_nums))
		var result = expression.execute([], null, true)
		label.text = str(result)
		fin_nums.clear()
		temp_nums.clear()
		temp_nums.append(str(result))


func _on_zero_button_resized() -> void:
	@warning_ignore("integer_division")
	%ZeroButton.offset_left = -get_window().size.x / 4
