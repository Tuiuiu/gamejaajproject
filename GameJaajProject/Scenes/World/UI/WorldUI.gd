extends Control

signal health_updated(health)

onready var world = get_parent()
var paused = false setget set_pause
onready var pause_overlay = get_node("CanvasLayer/PauseScreen")

func _ready():
    var player = world.get_node("Player")
    get_node("CanvasLayer/HealthBar").initialize(player.hp, player.MAX_HP)

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        self.paused = !paused
        get_tree().set_input_as_handled()

func set_pause(value: bool) -> void:
    paused = value
    get_tree().paused = value
    pause_overlay.visible = value
    
func _on_Player_health_changed(health):
    emit_signal("health_updated", health)
