extends KinematicBody2D


#var move_speed = 300
var move_velocity = 10
var gravity = 30
var jump_force = -600
var checkground = Vector2(0, -1)

var movement = Vector2()

var camera_goal = 1
var camera_difference = 0

#CHECKPOINTS
var y = 432
var x = 418

func _physics_process(delta):
	_move(delta)
	
	#cores
	
	var r = get_parent().r
	var g = get_parent().g
	var b = get_parent().b
	
	$bola.modulate = Color(r / 7, g / 7, b / 7)
	$particle_roll.process_material.color = Color(r / 9, g / 9, b / 9)

func _move(delta):
	movement.y += gravity
	
	#andar
	
	if Input.is_action_pressed("move_right"):
		movement.x += move_velocity
		#if movement.x >= move_speed:
		#	movement.x = move_speed
	
	if Input.is_action_pressed("move_left"):
		movement.x -= move_velocity
		#if movement.x <= -move_speed:
		#	movement.x = -move_speed
	
	#pular
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		movement.y = jump_force
		$jump.play()
	
	movement.x = movement.x * 0.99
	
	#rola kkkkkk pau
	if is_on_floor() or is_on_ceiling() or is_on_wall():
		if movement.x > 0:
			$roll.volume_db = (movement.x / 500) * 80 - 50
		else:
			$roll.volume_db = (-movement.x / 500) * 80 - 50
	else:
		$roll.volume_db = (($roll.volume_db + 80) * 0.98) - 80
		
	if $roll.volume_db > 0:
		$roll.volume_db = 0

	movement = move_and_slide(movement, checkground)
	
	#particuliculas
	
	if is_on_floor():
		$particle_roll.emitting = true
	else:
		$particle_roll.emitting = false
	
	$particle_roll.process_material.direction.x = -movement.x
	
	#cameramera
	

	if movement.x > 0:
		camera_goal = (movement.x / 200)
	elif movement.x < 0:
		camera_goal = (-movement.x / 200)
	
	if camera_goal < 0.5:
		camera_goal = 0.5
	
	if $Camera.zoom.x > camera_goal:
		camera_difference = $Camera.zoom.x - camera_goal
		$Camera.zoom.x = $Camera.zoom.x - (camera_difference / 500)
	elif $Camera.zoom.x < camera_goal:
		camera_difference = camera_goal - $Camera.zoom.x
		$Camera.zoom.x = $Camera.zoom.x + (camera_difference / 500)
	else:
		camera_difference = 0
	
	if $Camera.zoom.x < 0.5:
		$Camera.zoom.x = 0.5
	
	$Camera.zoom.y = $Camera.zoom.x
	

#func _on_Spike_body_entered(body):
#	$death.play()
#	position.y = 420
#	position.x = 430
#
#
#func _on_fallzone_body_entered(body):
#		movement.y = 0
#		position.y = 420
#		position.x = 430


func changeCheck(checkY, checkX):
	y = checkY
	x = checkX


func _on_deathzone_body_entered(body):
	if body.name == "Player":
		$death.play()
		movement.y = 0
		position.y = y
		position.x = x


func _on_checkpoint1_body_entered(body):
	if body.name == "Player":
		var coords = get_position()
		changeCheck(coords[1], coords[0])
