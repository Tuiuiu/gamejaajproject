extends "res://Scenes/Enemies/Enemy.gd"

var fireball = preload("res://Scenes/Enemies/Spells/EnemyRedFireball.tscn")
var close_to_floor = false
# voa a 140 pixels de altura


func _ready():
    #._ready()
    $Timer.wait_time = 2.0
    type = "flying_eye"
    fireball_cast()
    

func hit(type, dmg):
    if (type == "greenfireball"):
        take_damage(dmg)
    
func _physics_process(delta):
    ._physics_process(delta)

func fireball_cast():
    $AnimatedSprite.play("Dive")
    $AnimationPlayer.play("Dive")
    yield($AnimationPlayer, "animation_finished")
    close_to_floor = true
    $AnimatedSprite.play("Attack3")
    yield($AnimatedSprite, "animation_finished")
    if (!dead):
        var clone = fireball.instance()
        #clone.global_position = global_position
        #print(clone.position)
        #print(clone.global_position)
        clone.position = position
        clone.set_rotation($AnimatedSprite.rotation_degrees)
        get_parent().add_child(clone)
        close_to_floor = false
        $AnimatedSprite.play("Dive")
        $AnimationPlayer.play("Rise")
        yield($AnimatedSprite, "animation_finished")
        $AnimatedSprite.play("Run")
        $Timer.start()

func _on_Timer_timeout():
    fireball_cast()
