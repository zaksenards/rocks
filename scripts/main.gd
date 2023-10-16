extends Node2D

const asteroidPkg = preload("res://objects/asteroid.tscn");
const starPkg = preload("res://objects/star.tscn");
@onready var audioPlayer = $"AudioPlayer"
var playerScore = 0;

const theme = [
	"res://audio/Alone Against Enemy.ogg",
	"res://audio/Without Fear.ogg"
];

func _ready():
	$"asteroidTimer".start();
	audioPlayer.stream = load(theme[randi()%theme.size()]);
	audioPlayer.play();

func _process(delta):
	pass
	
func _on_asteroid_timer_timeout():
	var _direction = Vector2(0,0);
	var _position = Vector2(0,0);
	var _yDirection = [-10, 1000];
	var rand_value = 0;

	for i in range(randf_range(10,20)):
		randomize();
		rand_value = _yDirection[randi() % _yDirection.size()]
		_direction = Vector2(randi_range(100,1000), randi_range(100,1000));
		_position = Vector2(randi_range(-1000,1000), rand_value);
		var asteroid = asteroidPkg.instantiate();
		asteroid._start_at(get_angle_to(_direction), _position);
		add_child(asteroid);


func _on_audio_player_finished():
	audioPlayer.stream = load(theme[randi()%theme.size()]);
	audioPlayer.play();


func _on_star_timer_timeout():
	var _position = Vector2(0,0);
	for i in randi_range(0, 50):
		var star = starPkg.instantiate();
		star.position.x = randi_range(0,900);
		star.position.y = randi_range(0, 900);
		add_child(star);
		
func game_over():
	$"gameOver".visible = true;
	audioPlayer.stop();
	audioPlayer.stream = load("res://audio/Game Over.ogg");
	audioPlayer.play();

func _on_button_pressed():
	get_tree().reload_current_scene();

func score():
	var lbl:Label = $"HUD/score";
	playerScore+=1;
	lbl.text = "score: "+str(playerScore);
