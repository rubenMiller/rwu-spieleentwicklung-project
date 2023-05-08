extends Spatial


var recharge_time = 2 # is 2 seconds
var elapsed_time = 0
var ready_to_shoot: bool = false
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
		shoot_first_target()
		elapsed_time = 0
		ready_to_shoot = false
		
func shoot_first_target():
	print("Going to shoot: ", target_list[0])
	# get_node(target_list[0]).is_queued_for_deletion()
	print("target_list", target_list, "target_list")
	target_list[0].get_child(4).reduceHealth(1)
	print("Reduced Health by on for: ", target_list[0])
	# target_list.erase[target_list[0]]


func _on_radius_body_entered(body):
	print("Body entered: ", body)
	target_list.append(body)
	
	
func _on_radius_body_exited(body):
	print("Body entered: ", body)
	target_list.erase(body)
