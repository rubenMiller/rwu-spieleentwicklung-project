class_name WalkTiles
extends GridMap


var cells: Array = []
var _units := {}

func _ready() -> void:
	_reinitialize()
	
	cells = get_used_cells()
	print(cell_size)
	print(cells)
	
	print(_units)
	
	
func _reinitialize() -> void:
	_units.clear()

	for child in get_children():
		var unit := child as Unit
		if not unit:
			continue
		_units[unit.currentPosition] = unit


