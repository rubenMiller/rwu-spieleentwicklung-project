extends MeshInstance


var isSelected = false
export var idleMaterial: Material
export var selectedMaterial: Material

func _process(delta):
	if isSelected: 
		$MeshInstance.material_override = selectedMaterial
	else: 
		$MeshInstance.material_override = idleMaterial
