extends "res://Scenes/Enemies/Enemy.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
    ._ready()
    
func _physics_process(delta):
    ._physics_process(delta)

func _on_Area2D_body_entered(body):
    if (body.is_in_group("Player")):
        print ("MUDOU PRA ATAQUE")
        change_state("attack")
        body.hp -= 50
        yield($AnimatedSprite, "animation_finished")
        change_state("running")
