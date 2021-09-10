extends Node2D

var r = 1;
var g = 0;
var b = 0;

var time = 0

func _physics_process(delta):
	
	time += delta / 3
	
	var freq = 1
	var amplitude = 1
	
	r = (sin((time * freq)) * amplitude) + amplitude
	g = (sin((time * freq) + 2) * amplitude) + amplitude
	b = (sin((time * freq) + 4) * amplitude) + amplitude
	
#	print(r)
