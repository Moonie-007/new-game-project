extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var vision: Area2D = $Sprite/Vision
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var vision_collision: CollisionShape2D = $Sprite/Vision/CollisionShape2D

var alert: bool = false
var player: Player = Node2D = null  # Or Player = null if you want specific behavior

func _ready() -> void:
	animation_player.seek(randf_range(0, animation_player.current_animation_length))
	vision_collision.shape.radius = 10
	vision.body_entered.connect(_on_vision_body_entered)
	vision.body_exited.connect(_on_vision_body_exited)

func _physics_process(delta: float) -> void:
	if alert and player:
		change_direction()

func change_direction() -> void:
	if position.x - player.position.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func _on_vision_body_entered(body):
	if body is Player:
		alert = true
		player = body

func _on_vision_body_exited(body):
	if body is Player:
		alert = false
		player = null
