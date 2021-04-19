extends KinematicBody


var coordinates : Vector3

func _to_string():
	return str(coordinates)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func seteee(coords : Vector3):
	coordinates = coords


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
