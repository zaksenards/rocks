extends CharacterBody2D

const shootPkg = preload("res://objects/shoot.tscn");
@onready var animator = $"sprite/animator"
@onready var sprite = $"sprite"
const VELOCITY: float = 100

func _process(delta):
	if(Input.is_action_just_pressed("left_click")):
		var _shoot = shootPkg.instantiate();
		var _rotation = get_angle_to(get_global_mouse_position());; 
		var _position = $"sprite/gun".global_position;
		_shoot._start_at(_rotation, _position);
		get_tree().get_root().call_deferred("add_child", _shoot)

func _physics_process(delta):
	var _direction = Vector2(0,0);
	_direction.x = int(Input.is_action_pressed("key_right")) - int(Input.is_action_pressed("key_left"));
	_direction.y = int(Input.is_action_pressed("key_backward")) - int(Input.is_action_pressed("key_forward"));
	sprite.rotation = get_angle_to(get_global_mouse_position()) + PI/2;
	
	velocity = _direction * VELOCITY;
	move_and_slide();

func destroy():
	animator.play("destroy");

func _on_animator_animation_finished(anim_name):
	queue_free();
	get_tree().root.get_child(0).game_over();
