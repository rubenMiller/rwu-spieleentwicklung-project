extends Position3D

export var speed = 1.0
export var scroll_multiplier = 1.0

var velocity = Vector3.ZERO

func _physics_process(delta: float):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		translation.x -= speed
	if Input.is_action_pressed("move_left"):
		translation.x += speed
	if Input.is_action_pressed("move_backward"):
		translation.z -= speed
	if Input.is_action_pressed("move_forward"):
		translation.z += speed
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
			translation.y += speed * scroll_multiplier
		if event.button_index == BUTTON_WHEEL_UP and event.pressed:
			translation.y -= speed * scroll_multiplier

