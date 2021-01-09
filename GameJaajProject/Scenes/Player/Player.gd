extends KinematicBody2D

signal health_changed(health)
signal player_died
signal spell_cast(id, cd)
signal add_buff(id)
signal remove_buff(id)

var GRAVITY = 50.0
var JUMP_FORCE = 650.0
var velocity = Vector2()
var jump_count = 0
var state
var castSpells
var cooldownHandler
var availableSpells = []
var active = true
var bossfight = false
var hex = "none"
var casting = false
var cooldowns = {
    0: false, # Red Fireball
    1: false, # Black Fireball
    2: false, # Green Fireball
    3: false, # Flash Light
    4: false, # Red Hex Shield
    5: false, # Black Hex Shield
    6: false, # Green Hex Shield
    7: false, # Heal Chime
    8: false  # Toll the Dead
}
var MAX_HP = 100
var world
var camera
onready var dead = false
onready var hp = 10

func _ready():
    availableSpells.append(load("res://Scenes/Spells/Fireballs/Red_fireball.tscn"))
    availableSpells.append(load("res://Scenes/Spells/Fireballs/Black_fireball.tscn"))
    availableSpells.append(load("res://Scenes/Spells/Fireballs/Green_fireball.tscn"))
    availableSpells.append(load("res://Scenes/Spells/Bells/LightBell.tscn"))
    availableSpells.append(load("res://Scenes/Spells/Bells/DarkBell.tscn"))
    world = get_parent()
    castSpells = world.get_node("Spells")
    camera = world.get_node("Camera2D")
    change_state("run")   
        
func _physics_process(delta):
    if (active):
        if (!is_on_floor()):
            velocity.y += GRAVITY
        if (is_on_floor()):
            velocity.y = 0
            if (state == "fall"):
                change_state("run")
        if (Input.is_action_just_pressed("ui_up")):
            if (!dead):
                if (is_on_floor()):
                    velocity.y = -JUMP_FORCE
                    jump_count = 1
                    change_state("jump")
                elif (!is_on_floor()):
                    if jump_count < 2:
                        jump_count += 1
                        velocity.y = -JUMP_FORCE + 70
                        change_state("jump")   
        move_and_slide(velocity, Vector2(0, -1))

func _process(delta):
    if hp <= 0 or !active:
        pass
    elif (velocity.y > 0 && state == "jump"):
        change_state("fall")

func is_alive():
    return !dead
    
func change_state(new_state):
    if (state != new_state):
        match new_state:
            "run":
                if(!bossfight):
                    $AnimatedSprite.play("Run")
                else:
                    $AnimatedSprite.play("idle")
            "hit":
                $AnimatedSprite.play("Hit")
            "attack1":
                $AnimatedSprite.play("Attack 1")
            "attack2":
                $AnimatedSprite.play("Attack 2")
            "death":
                $AnimatedSprite.play("Death")
            "fall":
                $AnimatedSprite.play("Fall") 
            "jump":
                $AnimatedSprite.play("Jump")
            "idle":
                $AnimatedSprite.play("idle")
        state = new_state       

func hit(damage):
    if (!dead):
        if (hex != "none"):
            hex = "none"
            $HexAnimation.visible = true
            $HexAnimation.set_frame(0)
            $HexAnimation.play("Block")
            yield($HexAnimation, "animation_finished")
            $HexAnimation.visible = false
            emit_signal("remove_buff", 4)
            emit_signal("spell_cast", 4, 5)
        else:
            hp -= damage
            emit_signal("health_changed", hp)
            camera.shake(0.2, 15, 8)
            if (hp > 0):
                change_state("hit")
                $AnimationPlayer.play("DamageEffect")
                yield($AnimatedSprite, "animation_finished")
                if (!dead):
                    change_state("run")
            elif (hp <= 0):
                die()

func heal(healing):
    hp += healing
    if (hp > MAX_HP):
        hp = MAX_HP
    emit_signal("health_changed", hp)

func die():
    print("morreu")
    dead = true
    change_state("death")
    yield($AnimatedSprite, "animation_finished")
    $GenericTimer.wait_time = 3.0
    $GenericTimer.start()
    yield($GenericTimer, "timeout")
    emit_signal("player_died")

func get_target():
    if $RayCast2D.is_colliding():
        return $RayCast2D.get_collider()
    else:
        return null

func try_to_cast(index):
    # If player is alive
    if(is_alive() and active):
        # If skill is not on cooldown
        if (!casting and !cooldowns[index]):
            match index:
                0, 1, 2: # Red Fireball, Black Fireball, Green Fireball
                    fireball_cast(index)
                3: # Flashlight
                    flashlight_cast()
                4, 5, 6: # Red Hex, Black Hex, Green Hex 
                    hex_cast(index)
                7: # Heal Chime
                    heal_chime_cast()
                8: # Toll the Dead
                    toll_dead_cast()

func fireball_cast(type):
    var tgt = get_target()
    if (tgt == null):
        #NENHUM ALVO A VISTA
        pass
    else:
        var clone = availableSpells[type].instance()
        var src = $RayCast2D.position
        var dst = $RayCast2D.cast_to
        var dir = (dst - src).normalized()
        clone.set_direction(dir)
        clone.set_position(position)
        clone.set_rotation($AnimatedSprite.rotation_degrees)
        castSpells.add_child(clone) 
        cooldowns[type] = true
        casting = true
        change_state("attack2")
        emit_signal("spell_cast", type, (type + 0.5))
        yield($AnimatedSprite, "animation_finished")
        casting = false
        if (!dead):
            change_state("run")   

func flashlight_cast():
    world.flashlight_spell()
    #cooldowns[3] = true

func hex_cast(type):
    cooldowns[4] = true
    cooldowns[5] = true
    cooldowns[6] = true
    casting = true
    change_state("attack1")
    yield($AnimatedSprite, "animation_finished")
    match type:
        4: # Red Hex
            $HexAnimation.modulate = Color("#fe0617")
            hex = "red"
        5: # Black Hex
            $HexAnimation.modulate = Color("#3c2659")
            hex = "black"
        6: # Green Hex
            $HexAnimation.modulate = Color("#99d409")
            hex = "green"
    $HexAnimation.visible = true
    $HexAnimation.set_frame(0)
    $HexAnimation.play("Cast1")
    yield($HexAnimation, "animation_finished")
    casting = false
    change_state("run")
    $HexAnimation.play("Cast2")
    yield($HexAnimation, "animation_finished")
    emit_signal("add_buff", 4)
    $HexAnimation.stop()
    $HexAnimation.visible = false

func heal_chime_cast():
    cooldowns[7] = true
    change_state("attack1")
    yield($AnimatedSprite, "animation_finished")
    var clone = availableSpells[3].instance()
    clone.position = position 
    castSpells.add_child(clone)
    clone.cast_spell()
    yield(clone, "heal")
    if (!dead):
        heal(50)
        emit_signal("spell_cast", 7, 10.0)
        change_state("run")
    
func toll_dead_cast():
    cooldowns[8] = true
    change_state("attack1")
    yield($AnimatedSprite, "animation_finished")
    var clone = availableSpells[4].instance()
    clone.position = position
    castSpells.add_child(clone)
    clone.cast_spell()
    yield(clone, "toll")
    if (!dead):
        world.toll_the_dead()
        emit_signal("spell_cast", 8, 10.0)
        change_state("run")

func sequence_pressed(action):
    if (active):
        $CastingAudioEffects.sequence_pressed(action)

func cooldown_over_handler(id):
    if (id == 4):
        cooldowns[id+1] = false
        cooldowns[id+2] = false
    cooldowns[id] = false

func activate():
    active = true

func deactivate():
    active = false
