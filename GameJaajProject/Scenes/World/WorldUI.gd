extends Control

signal health_updated(health)

onready var world = get_parent()
var paused = false

func _ready():
    var player = world.get_node("Player")
    get_node("CanvasLayer/HealthBar").initialize(player.hp, player.MAX_HP)
    
func _process(delta):
    if (Input.is_action_just_pressed("ui_cancel")):
        if (paused):
            paused = false
            world.resume_game()
        else:
            paused = true
            world.pause_game()

func _on_Player_health_changed(health):
    emit_signal("health_updated", health)
