extends "res://Scenes/Enemies/Enemy.gd"

var damage = 10.0
onready var timer = $RevivalTime

func _ready():
    health = 20.0
    timer.wait_time = 2.0
    type = "skeleton"
    
func _physics_process(delta):
    ._physics_process(delta)

func _on_HitStart_body_entered(body):
    if (!dead):
        if (body.is_in_group("Player") and body.is_alive()):
            change_state("attack")
            yield($AnimatedSprite, "animation_finished")
            if(!dead):
                change_state("run")

func _on_HitStart_body_exited(body):
    if (!dead):
        if (body.is_in_group("Player") and body.is_alive()):
            body.hit(damage)

func hit(type, dmg):
    if (type == "redfireball"):
        take_damage(dmg)


func _on_RevivalTime_timeout():
    $AnimatedSprite.play("Revive")
    yield($AnimatedSprite, "animation_finished")
    dead = false
    change_state("run")

func die():
    dead = true
    $AnimatedSprite.play("Death")
    yield($AnimatedSprite, "animation_finished")
    timer.start()

func permadeath():
    dead = true
    $AnimatedSprite.play("Death")
