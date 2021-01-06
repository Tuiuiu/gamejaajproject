extends AnimatedSprite

signal heal
var animation_times = 0

func _ready():
    pass

func cast_spell():
    play("Heal")
    $AudioStreamPlayer.play()

func _on_LightBell_animation_finished():
    animation_times += 1
    if (animation_times == 1):
        emit_signal("heal")

func _on_AudioStreamPlayer_finished():
    queue_free()
