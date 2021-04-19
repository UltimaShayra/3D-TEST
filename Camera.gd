extends Camera


export var distance_to_origin = 25 # target is origin
var target = Vector3.ZERO setget set_target

var side_view = [PI/6 , 3*PI/6 , 5*PI/6 , 7*PI/6 , 9*PI/6 , 11*PI/6]
var current_view = 4
var y_angle = [PI/2 , PI/3 , PI/4, PI/6]
var current_angle = 3


func _ready():
	update_origin()
	
func set_target(value : Vector3):
	transform.origin -= target
	target = value
	transform.origin += target

func lower_view():
	current_angle += 1
	if current_angle == y_angle.size():
		current_angle = y_angle.size()-1
	else:
		rotation_degrees.x = -rad2deg(y_angle[current_angle])
		update_origin()
func up_view():
	current_angle -= 1
	if current_angle < 0:
		current_angle = 0
	else: 
		rotation_degrees.x = -rad2deg(y_angle[current_angle])
		update_origin()

func rotate_left():
	rotation_degrees.y -= rad2deg(PI/3) 
	current_view -=1
	if current_view < 0:
		current_view = side_view.size()-1
	update_origin()
func rotate_right():
	rotation_degrees.y += rad2deg(PI/3)
	current_view +=1
	if current_view == side_view.size():
		current_view = 0
	update_origin()
	
# 
func update_origin():
	transform.origin.z = -sin(side_view[current_view]) * distance_to_origin * cos(y_angle[current_angle]) + target.z
	transform.origin.x = cos(side_view[current_view]) * distance_to_origin * cos(y_angle[current_angle]) + target.x
	transform.origin.y = sin(y_angle[current_angle]) * distance_to_origin + target.y
