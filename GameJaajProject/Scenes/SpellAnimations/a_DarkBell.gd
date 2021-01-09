extends AnimatedSprite



func _ready():
   visible = false

func toll():
    if (visible == true):
        $AudioStreamPlayer.play()
        play("Toll")
        yield($".", "animation_finished")
        visible = false


func _on_AudioStreamPlayer_finished():
    emit_signal("Fade!")
    queue_free()
