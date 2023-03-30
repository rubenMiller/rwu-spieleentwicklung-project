extends GridMap

# Declare variables for selected unit and target position
var selected_unit = null
var target_position = null

# Declare a variable for the Navigation node
var navigation = null

func _ready():
	# Enable input processing
	set_process_input(true)
	
	# Get the Navigation node from the scene
	navigation = get_node("/root/Navigation")

func _input(event):
	# Check if the left mouse button is pressed
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			# Get the position of the mouse click in world coordinates
			var position = get_click_position(event.position)
			# Find a unit at the clicked position using `get_unit_at_position`
			var unit = get_unit_at_position(position)
			
			# If a unit was clicked, select it
			if unit != null:
				select_unit(unit)
			# If no unit was clicked and a unit is already selected, move it to the clicked position
			elif selected_unit != null:
				move_unit(position)
				
func get_unit_at_position(position):
	# Get a list of all nodes in the "units" group
	var units = get_tree().get_nodes_in_group("units")
	
	# Loop through each unit and check if it's in the given position
	for unit in units:
		# Get the position of the unit in world coordinates
		var unit_position = unit.get_translation()
		
		# If the unit is in the given position, return it
		if position.distance_to(unit_position) < 0.1:
			return unit
			
	# If no unit was found, return null
	return null
	
func select_unit(unit):
	# Deselect the previously selected unit if there was one
	if selected_unit != null:
		selected_unit.modulate = Color.white
		
	# Select the new unit by changing its modulate color to red
	selected_unit = unit
	selected_unit.modulate = Color.red
	
func move_unit(position):
	# Set the target position for the selected unit
	target_position = position
	# Find a path from the current position to the target position using `Navigation`
	var path = navigation.get_simple_path(selected_unit.get_translation(), target_position)
	# Make the selected unit follow the path
	selected_unit.follow_path(path)
	
	# Reset the selected_unit and target_position variables
	selected_unit = null
	target_position = null
	
func get_click_position(screen_position):
	# Get the camera node from the scene
	var camera = get_node("/root/Camera")
	
	# Use the camera to project the screen position to world coordinates
	var ray_origin = camera.project_ray_origin(screen_position)
	var ray_direction = camera.project_ray_normal(screen_position)
	var ray = RayCast.new()
	ray.cast_to = ray_origin + ray_direction * 1000
	ray.force_raycast_update()
	
	# If the ray hits something, return the hit position
	if ray.is_colliding():
		return ray.get_collision_point()
	
	# If the ray doesn't hit anything, return a position far away in the direction of the ray
	return ray_origin + ray_direction * 1000

