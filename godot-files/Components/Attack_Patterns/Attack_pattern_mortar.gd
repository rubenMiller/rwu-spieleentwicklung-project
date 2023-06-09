extends Spatial

export (Resource) var impact_area
export var air_time := 2.0

func attack(target, damage):
	var area = impact_area.instance()
	area.damage = damage
	area.air_time = air_time
	add_child(area)
	area.global_transform.origin = target.translation
