extends Spatial

onready var camera = get_node("Camera")

export(Vector3) var TILE_SIZE = Vector3(.866*2 , .5 , 2) #0.5 pour la pointe

var cell = preload("res://Cell.tscn")

func _ready():
	var array : Array
	
	for k in range(0,5):
		for i in range(0,5):
			var new = cell.instance()
			new.transform.origin = Vector3(i * (TILE_SIZE.x+.1) + (TILE_SIZE.x / 2)*k, 0 , 1.6*k)
			new.seteee(Vector3(i , 0 , k))
			get_node("Map").add_child(new)
	
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var lenght = 1000
			var mouse_coords = get_viewport().get_mouse_position()
			var camera = get_node("Camera")
			var from = camera.project_ray_origin(mouse_coords)
			var to = from + camera.project_ray_normal(mouse_coords) * lenght
			var space_state = get_world().get_direct_space_state()
			if space_state.intersect_ray(from , to):
				print(space_state.intersect_ray(from , to).collider)
				camera.target = space_state.intersect_ray(from , to).collider.translation
				
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_D:
			camera.rotate_right()
		if event.pressed and event.scancode == KEY_A:
			camera.rotate_left()
		if event.pressed and event.scancode == KEY_W:
			camera.up_view()
		if event.pressed and event.scancode == KEY_S:
			camera.lower_view()
	
