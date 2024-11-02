extends StaticBody2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


const diagonal = sin(PI/4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var x_axis = Input.get_axis("ui_left", "ui_right")
	var y_axis = Input.get_axis("ui_up", "ui_down")
	if x_axis != 0 && y_axis != 0:
		x_axis *= diagonal
		y_axis *= diagonal
	
	self.move_local_x(x_axis * speed * delta)
	self.move_local_y(y_axis * speed * delta)	
	
