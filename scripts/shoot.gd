extends Area2D

const VELOCITY = 20;
var direction: Vector2;

func _ready():
	set_physics_process(true);
	$"Timer".start();
	$"AudioPlayer".play();

func _start_at(_rotation, _position):
	direction = Vector2(VELOCITY, 0).rotated(_rotation);
	position = _position;
	rotation = _rotation;

func _physics_process(delta):
	position+=direction*VELOCITY*delta;

func _on_timer_timeout():
	destroy();

func _on_area_entered(body: Area2D):
	destroy();
	get_tree().root.get_child(0).score();
	body.destroy();
	
func destroy():
	queue_free();
