extends Node2D

func stop_motion():
    $Sprite/AnimationPlayer.stop(false)
    $MeshInstance2D/Light2D/AnimationPlayer.stop(false)
    
func resume_motion():
    $Sprite/AnimationPlayer.play()
    $MeshInstance2D/Light2D/AnimationPlayer.play()
