extends Node2D

func _ready():
    while true:
        $AquaPinkBG/AnimationPlayer.play("FadeOut")
        yield($AquaPinkBG/AnimationPlayer, "animation_finished")
        $BlueBG/AnimationPlayer2.play("FadeIn")
        yield($BlueBG/AnimationPlayer2, "animation_finished")
        $BlueBG/AnimationPlayer2.play("FadeOut")
        yield($BlueBG/AnimationPlayer2, "animation_finished")
        $AquaPinkBG/AnimationPlayer.play("FadeIn")
        yield($AquaPinkBG/AnimationPlayer, "animation_finished")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
