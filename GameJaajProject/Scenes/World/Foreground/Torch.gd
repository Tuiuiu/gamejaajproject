extends Node2D

var velocity = Vector2(-60, 10)
# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play("Torchlight")

func _physics_process(delta):
    position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
