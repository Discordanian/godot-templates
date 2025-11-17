extends Control

@export var grid: GridContainer
@export var columns: int


func random_label() -> Label:
    var l: Label = Label.new()
    l.text = "This is text for a label " + str(randi() % 1234)
    return l
    
func random_button() -> Button:
    var b: Button = Button.new()
    b.text = "This is text for a Button " + str(randi() % 100)
    return b    

func random_lineEdit() -> LineEdit:
    var le: LineEdit = LineEdit.new()
    le.text = "This is text for a Line Edit " + str(randi() % 10)
    return le

func random_node() -> Node:
    var x: int = [1,2,3].pick_random()
    if x == 1:
        return random_label()
    if x == 2:
        return random_button()
    return random_lineEdit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    grid.columns = columns
    for i: int in range(columns):
        var b: Button = Button.new()
        b.text = "Column " + str(i+1)
        grid.add_child(b)
        if i == 2:
            b.size_flags_horizontal = Control.SIZE_EXPAND
            b.size_flags_stretch_ratio = 4 
    for i: int in range(columns * 100):
        grid.add_child(random_node())
