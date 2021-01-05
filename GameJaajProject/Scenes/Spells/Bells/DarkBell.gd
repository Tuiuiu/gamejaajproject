extends AnimatedSprite

signal toll
var animation_times = 0

func _ready():
    pass

func cast_spell():
    play("Toll")
    $AudioStreamPlayer.play()

func _on_DarkBell_animation_finished():
    animation_times += 1
    if (animation_times == 1):
        emit_signal("toll")
        
func _on_AudioStreamPlayer_finished():
    queue_free()
