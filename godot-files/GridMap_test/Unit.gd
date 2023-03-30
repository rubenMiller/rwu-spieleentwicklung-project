extends KinematicBody

# Declare variables for the current path and target position
var current_path = []
var target_position = null

# Declare a variable for the Navigation node
var navigation = null

# Declare variables for the grid size and cell offset
var grid_size = Vector3(2, 0, 2)  # X and Z dimensions of each grid cell
var cell_offset = Vector3(-2, 0, -2)  # Offset from the origin to the center of the first cell

func _ready():
	# Get the Navigation node from the scene
	navigation = get_node("/root/Navigation")

func follow_path(path):
	# Set the current path for the unit to follow
	current_path = path
	# Set the target position to the first point
	target_position = current_path[0]

func _physics_process(delta):
	# If there is a current path, move towards the target position
	if current_path.size() > 0:
		# Calculate the distance and direction to the target position
		var direction = (target_position - global_transform.origin).normalized()
		var distance = (target_position - global_transform.origin).length()

		# If the unit has reached the target position, remove it from the path
		if distance < 0.1:
			current_path.remove(0)
			if current_path.size() > 0:
				target_position = current_path[0]

		# Move the unit towards the target position
		var velocity = direction * min(distance, 5) / delta
		move_and_slide(velocity)
