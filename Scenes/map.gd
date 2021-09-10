extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _physics_process(delta):
	var r = get_parent().r
	var g = get_parent().g
	var b = get_parent().b
	
	modulate = Color(r, g, b)

