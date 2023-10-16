extends Node2D

func _ready():
	$"sprite/animator".play("star");

func _process(delta):
	pass


func _on_animator_animation_finished(anim_name):
	queue_free();
