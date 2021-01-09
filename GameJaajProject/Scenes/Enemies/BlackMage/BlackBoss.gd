extends KinematicBody2D

var MAX_HP = 150.0
var health = 150.0
var state
var type = "boss"
var castDirection = Vector2(-1, 0).normalized()
var velocity = Vector2(0, 60.0)
var count = 0
var combo = 0
onready var active = true
onready var dead = false
var fireballs = [
    preload("res://Scenes/Enemies/Spells/EnemyRedFireball.tscn"),
    preload("res://Scenes/Enemies/Spells/EnemyBlackFireball.tscn"),
    preload("res://Scenes/Enemies/Spells/EnemyGreenFireball.tscn")
   ]

signal boss_dead

func _ready():
    $AnimatedSprite.flip_h = true
    active = true
    $Fireballs.start()
    change_state("idle")

func _physics_process(delta):    
    if (active):
        move_and_slide(velocity, Vector2(0, -1))
    
func _process(delta):
    pass 
    
func start():
    $Fireballs.start()
    $DarkLight.start()
    
func reset():
    active = true
    health = MAX_HP
    change_state("idle")

func change_state(new_state):
    if (state != new_state):
        match new_state:
            "run":
                $AnimatedSprite.play("Run")
            "hit":
                $AnimatedSprite.play("Hit")
            "idle":
                $AnimatedSprite.play("Idle")
            "attack":
                $AnimatedSprite.play("Attack")
            "attack2":
                $AnimatedSprite.play("Attack2")
            "death":
                die()
        state = new_state

func hit(type, dmg):
    if (type == "redfireball" or type == "blackfireball" or type == "greenfireball"):
        take_damage(dmg)

func die():
    dead = true
    $AnimatedSprite.play("Death")
    yield($AnimatedSprite, "animation_finished")
    emit_signal("boss_dead")

func clear():
    queue_free()

func take_damage(dmg):
    health -= dmg
    if (health <= 0):
        change_state("death")
    else:
        change_state("hit")
        yield($AnimatedSprite, "animation_finished")
        change_state("idle")

func is_alive():
    return !dead

func _on_Fireballs_timeout():
    count += 1
    if (count < 5):
        var idx = randi()%3
        var clone = fireballs[idx].instance()
        clone.set_direction(castDirection)
        clone.position = clone.position + Vector2(0, 60)
        clone.boss = true
        add_child(clone)
    elif (count == 6):
        $ComboFireball.start()
        count = 0
    $Fireballs.start()

func _on_DarkLight_timeout():
    pass # Replace with function body.


func _on_ComboFireball_timeout():
    var clone = fireballs[combo].instance()
    clone.set_direction(castDirection)
    clone.position = clone.position + Vector2(0, 60)
    clone.boss = true
    add_child(clone)
    combo += 1
    if (combo == 3):
        $ComboFireball.stop()
        combo = 0
    else:
        $ComboFireball.start()
