extends GridMap
class_name WalkTiles

export (Resource) var idle_tile 
export (NodePath) var tile_container

var cells: Array = []

func _ready() -> void:
	visible = false
	
	tile_container = get_node(tile_container)
	cells = get_used_cells()
	#print(cells)
	tiles_on_points()
	
func tiles_on_points():
	for cell in cells:
		var cell_world = map_to_world(cell.x,cell.y,cell.z)
		cell_world.y += 1
		
		var tile = idle_tile.instance()
		tile.translation = cell_world
		tile.add_to_group("selectable_tiles")
		tile_container.add_child(tile)
