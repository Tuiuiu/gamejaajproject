extends CenterContainer

onready var overlay = get_parent()
  
func _on_Fireballs_pressed():
    overlay.open_grimoire("Fireballs/")

func _on_Hexes_pressed():
    overlay.open_grimoire("Hexes/")

func _on_Bells_pressed():
    overlay.open_grimoire("Bells/")
