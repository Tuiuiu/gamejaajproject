extends "res://Scenes/Enemies/Enemy.gd"

var damage = 10.0
var skill = 0
var behavior = "idle"
var spells = [
    preload("res://Scenes/Enemies/Spells/EnemyRedFireball.tscn"),
    preload("res://Scenes/Enemies/Spells/EnemyGreenFireball.tscn")
   ]

func _ready():
    #._ready()
    type = "cultist"
    health = 20.0
    $Timer.wait_time = 2.0
    $AnimatedSprite.flip_h = true
    change_state("move")
    $Timer.start()
    
func _physics_process(delta):
    ._physics_process(delta)

func hit(type, dmg):
    if (type == "blackfireball"):
        take_damage(dmg)

func _on_Timer_timeout():
    if (!dead):
        fireball_cast()
    
func fireball_cast():
    change_state("attack2")
    yield($AnimatedSprite, "animation_finished")
    if(!dead):
        change_state("move")
        var spellId = randi()%3
        var spell
        if (spellId == 2):
            spell = spells[1]
        else:
            spell = spells[0]
        var clone = spell.instance()
        clone.position = position
        clone.set_rotation($AnimatedSprite.rotation_degrees - 20)
        get_parent().add_child(clone)
        $Timer.start()
