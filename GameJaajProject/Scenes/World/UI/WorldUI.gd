extends Control

signal health_updated(health)

onready var world = get_parent()
onready var pause_overlay = get_node("CanvasLayer/PauseScreen")

func _ready():
    var player = world.get_node("Player")
    get_node("CanvasLayer/HealthBar").initialize(player.hp, player.MAX_HP)

func _unhandled_input(event: InputEvent) -> void:
    if Global.active_menu == 'pause' or Global.active_menu == null:
        var paused = get_tree().paused
        if event.is_action_pressed("ui_cancel"):
            if paused:
                world.resume_game()
                pause_overlay.visible = false
                Global.active_menu = null
            else:
                world.pause_game()
                pause_overlay.visible = true
                Global.active_menu = "pause"
    
func _on_Player_health_changed(health):
    emit_signal("health_updated", health)
