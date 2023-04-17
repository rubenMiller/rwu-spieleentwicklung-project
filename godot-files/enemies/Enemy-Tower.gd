extends Spatial


var recharge_time = 2 # is 2 seconds
var elapsed_time = 0
var ready_to_shoot: bool = false
export (NodePath) var troop1Path
onready var troop1Node = get_node(troop1Path)
export (NodePath) var troop2Path
onready var troop2Node = get_node(troop2Path)
var target_list = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ready_to_shoot == false:
		elapsed_time += delta
		if elapsed_time >= recharge_time:
			print("Relad successfull!")
			ready_to_shoot = true
	
	if target_list.size() > 0 && ready_to_shoot:
		# print("The node ", target_list[0], " will be shot at")
		pass

func _on_radius_area_entered(area):
	print(area, " entered the radius")
	target_list.append(area)


func _on_radius_area_exited(area):
	print(area, " left the radius")
	target_list.erase(area)
	print(target_list)
