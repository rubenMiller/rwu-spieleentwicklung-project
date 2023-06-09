extends Spatial

func attack(target, damage):
	target.get_node("Health_Component").reduce_health(damage)
