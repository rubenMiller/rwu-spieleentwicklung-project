extends Spatial

onready var timer: Timer = $Timer

var enabled := false

func _ready() -> void:
	pass 

func on_interaction(value):
	enabled = value
	
	if enabled:
		print("timer starts")
		timer.start()
	if not enabled:
		timer.stop()

func _on_Timer_timeout() -> void:
	SignalBus.emit_signal("won")	
