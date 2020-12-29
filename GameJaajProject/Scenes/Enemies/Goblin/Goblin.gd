extends "res://Scenes/Enemies/Enemy.gd"

var damage = 10.0

func _ready():
    ._ready()
    
func _physics_process(delta):
    ._physics_process(delta)

func _on_HitStart_body_entered(body):
    if (body.is_in_group("Player")):
        change_state("attack")
        yield($AnimatedSprite, "animation_finished")
        change_state("run")

func _on_HitStart_body_exited(body):
    if (body.is_in_group("Player")):
        body.hit(damage)


