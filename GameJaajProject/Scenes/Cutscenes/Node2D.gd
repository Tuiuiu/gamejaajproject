extends Node2D


func _ready():
    $CutscenePlayer.play("Run")
    $AnimationPlayer.play("Arrive")
    yield($AnimationPlayer,"animation_finished")
    $CutscenePlayer.play("Idle")
    

