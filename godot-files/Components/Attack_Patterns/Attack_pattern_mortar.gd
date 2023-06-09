extends Spatial

export (Resource) var impact_area

func attack(target, damage):
	var area = impact_area.instance()
	add_child(area)
	area.global_transform.origin = target.translation
