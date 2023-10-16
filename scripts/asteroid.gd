extends Area2D

@onready var animator = $"sprite/animator"
const VELOCITY = 5;
var direction = Vector2(0,0);

func _start_at(_rotation, _position):
	direction = Vector2(VELOCITY, 0).rotated(_rotation);
	position = _position;
	randomize()
	rotation = randf();

func _physics_process(delta):
	position+=direction*VELOCITY*delta;

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();

func destroy():
	$"player".play();
	animator.play("destroy");

func _on_player_finished():
	queue_free();


func _on_body_entered(body: PhysicsBody2D):
	body.destroy();
