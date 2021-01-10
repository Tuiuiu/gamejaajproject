extends Node2D


func _ready():
    $CanvasLayer/DialogBox.dialog = [["Hello, friend!", "Wolf"],
    ["How can one tower support that many merchants, I wonder.", "Lumorith"],
    ["I'm afraid we don't have the time to chat, wizard. I've been hearing strange sounds from the floors above.","Wolf"],
    ["It seems like the Black Mage is preparing the Tower for the summoning of Tharnax.", "Wolf"],
    ["Then I must be on my way. Take care, Mr. Wolf.", "Lumorith"],
    ["Wait! At least take those with you!","Wolf"],
    ["Those are... too powerful even for a seasoned wizard! I cannot have them!", "Lumorith"],
    ["Trust me, friend, you'll need them on your way up. Now, go save us... And your brother.", "Wolf"],
    ["How could you know that he is my brother? I see, that sharp mind, you must be...", "Lumorith"],
    ["Vael, the Light of the East. There is some irony to the title now, isn't it?", "Vael"],
    ["Not really.", "Lumorith"],
    ["Yeah, now that I came to think of it... Anyway, get going!", "Vael"],
    ["Farewell, and thank you!", "Lumorith"],
    ["Lumorith has learned two new spells!", ""],
    ["Press H-E-A-L or T-O-L-L to active them in battle!", ""],
    ["*Woof* (Remember to check your grimoire for more info on those spells) *woof*", "Vael"]]
    $CanvasLayer/DialogBox.load_dialog()
    yield($CanvasLayer/DialogBox, "end_of_dialog")
    Global.goto_scene("res://Scenes/World/World.tscn")

