class_name Unit
extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material
export var MAX_SPEED := 10.0

var _velocity := Vector3.ZERO

onready var current_position := global_transform.origin
onready var target_position := current_position
onready var isSelected = false 
onready var _agent: NavigationAgent = $NavigationAgent

onready var tile_handler = get_node("../tile_handler")

func _ready():
	_agent.set_target_location(current_position)
	display_selected_unit()
	
	tile_handler.connect("tile_selected", self, "move") # aufruf der move funktion
	
func _process(_delta: float) -> void:
	if _agent.is_navigation_finished(): 
		return
		
	var direction := global_transform.origin.direction_to(_agent.get_next_location())
	_velocity = direction * MAX_SPEED
	move_and_slide(_velocity)
	
func move(target_tile):
	if isSelected:
		target_position = target_tile.global_transform.origin
		_agent.set_target_location(target_position)
		
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	
func display_selected_unit():
	$Label3D.visible = isSelected
	if isSelected: $MeshInstance.material_override = selectedMaterial
	else: $MeshInstance.material_override = idleMaterial
	
func _debug_information():
	print("------------------------------------------")
	print("Global Position:", global_transform.origin)
	print("distance to target:",_agent.distance_to_target())
	print("Velocity",_velocity)
	#set_process_unhandled_input(selection)
