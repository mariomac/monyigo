extends StaticBody2D

@export var speed = 100

const shots_per_second = 10
const consecutive_shots_max_seconds = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


const diagonal = sin(PI/4)

var bullet = preload("res://Scenes/bullet.tscn")
var rng = RandomNumberGenerator.new()

var next_shot_in = 0
var must_be_shooting = false
var consecutive_shots_seconds = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	manage_shots(delta)
	
	var x_axis = Input.get_axis("ui_left", "ui_right")
	var y_axis = Input.get_axis("ui_up", "ui_down")
	if x_axis != 0 && y_axis != 0:
		x_axis *= diagonal
		y_axis *= diagonal
	
	self.move_local_x(x_axis * speed * delta)
	self.move_local_y(y_axis * speed * delta)	
	
func manage_shots(delta: float):
	if Input.is_action_just_pressed("shot"):
		must_be_shooting = true
		# this frame will send the first shot
		next_shot_in = delta
		consecutive_shots_seconds = 0

	if Input.is_action_just_released("shot"):
		must_be_shooting = false

	if must_be_shooting:
		consecutive_shots_seconds += delta
		if consecutive_shots_seconds >= consecutive_shots_max_seconds:
			must_be_shooting = false
		else:
			next_shot_in -= delta
			if next_shot_in <= 0:
				next_shot_in += 1.0/shots_per_second
				var bullet_instance = bullet.instantiate(PackedScene.GEN_EDIT_STATE_MAIN) as StaticBody2D
				bullet_instance.position = self.position
				bullet_instance.angle = rng.randfn(0, 0.15)
				#bullet_instance.notify_property_list_changed()
				get_parent().add_child(bullet_instance)
