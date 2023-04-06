extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var selected = false
onready var tile_handler = get_node("../tile_handler")
onready var _agent: NavigationAgent = $NavigationAgent

var _velocity := Vector3.ZERO

func _ready():
	$Label3D.hide()
	$MeshInstance.material_override = idleMaterial
	_agent.set_target_location(global_transform.origin)
	tile_handler.connect("tile_selected", self, "move") # aufruf der move funktion
	
func _physics_process(delta: float) -> void:
	if _agent.is_navigation_finished():
		return
		
	var direction := global_transform.origin.direction_to(_agent.get_next_location())
	direction.normalized()
	_velocity = direction * 10
	_velocity = move_and_slide(_velocity)
	
func _unhandled_input(event: InputEvent) -> void:
	handle_input(event)
	#_state._unhandled_input(event)
	
func move(child):
		_agent.set_target_location(child.global_transform.origin)
		
func handle_input(event):
	if event:
		tile_handler.connect("tile_selected", self, "move")
	else:
		tile_handler.disconnect("tile_selected", self, "move")
	
	
func _on_SelectionArea_selection_toggled(selection):
	set_process_unhandled_input(selection)
	if selection:
		$Label3D.show()
		$MeshInstance.material_override = selectedMaterial
		selected = true
	else:
		$Label3D.hide()
		$MeshInstance.material_override = idleMaterial
		
