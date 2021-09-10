extends StaticBody2D


func _on_Spike_body_entered(body):
	var verification = body.name
	if verification == "Player":
		get_tree().reload_current_scene()
