extends Sprite

# sprites
var grassTex = preload("res://Scenes/SubScenes/grass.tscn")
var tilledTex = preload("res://Scenes/SubScenes/tilled.tscn")
var sapTex = preload("res://Scenes/SubScenes/sapling.tscn")
var waterTex = preload("res://Scenes/SubScenes/water.tscn")
var witherTex = preload("res://Scenes/SubScenes/wither.tscn")
var bloomTex = preload("res://Scenes/SubScenes/bloom.tscn")

var time = 0.0

# spriteLoaders
var current
var currentGrass
var currentTilt
var currentSap
var currentWatering
var currentWithered
var currentBloom

# timed logic
var state = 0
var plantstart=-1
var waterStart=-1
var timesWatered=0
var notwithered=true
var bloomCondition = false
var waterWait = 1.5
var harvestWait = 5

func _ready():
	currentGrass = grassTex.instance()
	currentTilt = tilledTex.instance()
	currentSap = sapTex.instance()
	currentWithered = witherTex.instance()
	currentBloom = bloomTex.instance()
	
	add_child(currentGrass)

func advance():
	
	# tilling state = 1
	if state == 0:
		remove_child(currentGrass)
		add_child(currentTilt)
		
	# planting state = 2
	elif state == 1:
		add_child(currentSap)
		plantstart=time
		
	# watering state = 3
	elif state == 2:
		watering()
		waterStart=time
	
	# after withering reset
	elif state == -1:
		remove_child(currentWithered)
		remove_child(currentWatering)
		state = 0
		plantstart=-1
		waterStart=-1
		timesWatered=0
		notwithered=true
		bloomCondition = false
	
	# withering state > 3
	elif state == 3:
		if !bloomCondition:
			wither()
			state=-2
	
	state+=1
	
func bloom():
	remove_child(currentSap)
	add_child(currentBloom)
	pass
	
func wither():
	remove_child(currentSap)
	add_child(currentWithered)
	notwithered = false

func watering():
	if timesWatered==0:
		currentWatering = waterTex.instance()
		add_child(currentWatering)
	timesWatered+=1
	
func time_irrigation():
	if waterStart>0 and time>waterStart+waterWait:
		remove_child(currentWatering)
		
	if !bloomCondition and notwithered and waterStart>0 and time>waterStart+harvestWait:
		bloomCondition=true
		bloom()
		
	if plantstart>0 and notwithered and time>plantstart+harvestWait and timesWatered==0:
		wither()
		state=-1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time+=delta
	time_irrigation()
	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		advance()
