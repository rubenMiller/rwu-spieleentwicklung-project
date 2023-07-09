extends Spatial


export (Resource) var progress_color_disabled
export (Resource) var progress_color_enabled

export (Resource) var signal_color_red

onready var win_timer: Timer = $win_timer
onready var timer: Timer = $Timer
onready var round_lights: Spatial = $round_lights
onready var other_lights: Spatial = $other_lights
onready var progress := 1.0
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var enemy_detected: AudioStreamPlayer = $enemy_detected
onready var shut_down: AudioStreamPlayer = $shut_down

var enabled := false

func _ready() -> void:
	for n in round_lights.get_child_count():
		round_lights.get_child(n).mesh.material = progress_color_disabled
	for n in round_lights.get_child_count():
		other_lights.get_child(n).mesh.material = signal_color_red
	
	animation_player.play("arrow_up_down")
	
func _process(delta: float) -> void:
	if enabled:
		progress = timer.time_left / timer.wait_time
	else:
		progress = 1.0
	print(1.0 - progress)
	for n in round_lights.get_child_count():
		if 1.0 - progress > float(n)/round_lights.get_child_count():
			round_lights.get_child(n).mesh.material = progress_color_enabled
		else: 
			round_lights.get_child(n).mesh.material = progress_color_disabled
	
	if 1.0 - progress > float(round_lights.get_child_count() - 1)/round_lights.get_child_count():
		for n in round_lights.get_child_count():
			other_lights.get_child(n).mesh.material = progress_color_enabled

func on_interaction(value):
	enabled = value
	
	if enabled:
		print("timer starts")
		enemy_detected.play()
		timer.start()
	if not enabled:
		timer.stop()

func _on_Timer_timeout() -> void:
	win_timer.start()
	enemy_detected.stop()
	shut_down.play()
	
func _on_win_timer_timeout() -> void:
	SignalBus.emit_signal("won")	
