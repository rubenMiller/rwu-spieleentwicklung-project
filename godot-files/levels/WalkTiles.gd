extends GridMap
class_name WalkTiles

export (Resource) var idle_tile 
export (NodePath) var tile_container

var cells: Array = get_used_cells()
var selectable_tiles = []

func _ready() -> void:
	visible = false
	
	tile_container = get_node(tile_container)
	create_tiles_on_points()
	#print(get_used_cells_by_item(0))
	#print(get_used_cells_by_item(1))
	
	selectable_tiles = get_tree().get_nodes_in_group("selectable_tiles")
	
func _process(_delta: float) -> void:
	var selected_troops = get_tree().get_nodes_in_group("troop_selection")

	if selected_troops != []:
		set_visibility_of_tiles(true)
	else:
		set_visibility_of_tiles(false)
	
func create_tiles_on_points():
	for cell in cells:
		var cell_world = map_to_world(cell.x,cell.y,cell.z)
		cell_world.y -= 1
		var tile :Tile = idle_tile.instance()
		tile.translation = cell_world
		tile.add_to_group("selectable_tiles")
		if cell == get_used_cells_by_item(1)[0]:
			tile.add_to_group("win_tiles")
		tile_container.add_child(tile)
		
func set_visibility_of_tiles(is_visible: bool):
	for tile in selectable_tiles:
			tile.visible = is_visible
