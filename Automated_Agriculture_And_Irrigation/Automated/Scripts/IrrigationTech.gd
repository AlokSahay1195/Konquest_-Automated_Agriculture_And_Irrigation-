extends Sprite

func _ready():
	pass # Replace with function body.

func _on_Area2D_input_event(viewport, event, shape_idx):
	print("hi")
	if event is InputEventMouseButton && event.pressed:
		get_tree().get_root().get_node("Game").get_node("Board").isPrimitive = false
		print(get_tree().get_root().get_node("Game").get_node("Board").isPrimitive)
		get_tree().get_root().get_node("Game").get_node("Board").actionState = 2


#func _process(delta):
#	pass
