extends "res://Scenes/Enemies/Enemy.gd"

func _ready():
    ._ready()
    
func _physics_process(delta):
    ._physics_process(delta)

func _on_Area2D_body_entered(body):
    if (body.is_in_group("Player")):
        change_state("attack")
        yield($AnimatedSprite, "animation_finished")
        #body.hp -= 50
        change_state("run")
