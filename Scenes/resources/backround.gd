extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _physics_process(delta):
	var r = get_parent().get_parent().r / 2
	var g = get_parent().get_parent().g / 2
	var b = get_parent().get_parent().b / 2
	
	modulate = Color(r, g, b)
