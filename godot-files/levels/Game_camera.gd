extends Position3D

export var move_speed = 1.0
export var scroll_speed = 1.0

export var boundary_left := 0.0
export var boundary_right := 0.0
export var boundary_forward := 0.0
export var boundary_backward := 0.0
export var boundary_up := 0.0
export var boundary_down := 0.0

var velocity = Vector3.ZERO

func _physics_process(delta: float):
	print(translation)
	
	if Input.is_action_pressed("move_right") and translation.x > boundary_right:
		translation.x -= move_speed
	if Input.is_action_pressed("move_left") and translation.x < boundary_left:
		translation.x += move_speed
	if Input.is_action_pressed("move_backward") and translation.z > boundary_backward:
		translation.z -= move_speed
	if Input.is_action_pressed("move_forward") and translation.z < boundary_forward:
		translation.z += move_speed
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_DOWN and event.pressed and translation.y < boundary_up:
			translation.y += scroll_speed
		if event.button_index == BUTTON_WHEEL_UP and event.pressed and translation.y > boundary_down:
			translation.y -= scroll_speed

