extends StaticBody2D

@export var angle = 0;

var speed = 300
var x_speed = speed
var y_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_local_x(x_speed * delta)
	move_local_y(y_speed * delta)
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
