extends Node

var isPrimitive = true
var actionState = 0
var boardLimit_R = 280
var originX = 88
var originY = 136

# actionState logic, when iterating through squares, only improve if state = actionstate 

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mousePos = get_viewport().get_mouse_position()
		print(mousePos)
		print(isPrimitive)
		if !isPrimitive and mousePos.x <= boardLimit_R and mousePos.x >= originX:
			var row = ceil((mousePos.y-originY)/24) 
			print(row)
			advTech(row)
		
func advTech(row):
	for n in get_children():
		if n.position.y == originY + (row-1)*24 and n.get_child(0).get_child(0).state == actionState:
			n.get_child(0).get_child(0).advance()
			
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
