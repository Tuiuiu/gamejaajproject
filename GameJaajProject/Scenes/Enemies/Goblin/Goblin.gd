extends "res://Scenes/Enemies/Enemy.gd"

var damage = 0.0

func _ready():
    ._ready()
    
func _physics_process(delta):
    ._physics_process(delta)

func _on_HitStart_body_entered(body):
    if (!dead):
        if (body.is_in_group("Player")):
            change_state("attack")
            yield($AnimatedSprite, "animation_finished")
            change_state("run")

func _on_HitStart_body_exited(body):
    if (!dead):
        if (body.is_in_group("Player")):
            body.hit(damage)

func hit(type):
    if (type == "fireball"):
        change_state("death")
