extends Area2D

signal bcPie_collected

func _ready():
	$AnimatedSprite.play("Idle")


func _on_ButterChicken_body_entered(body):
	emit_signal("bcPie_collected")
	$SoundPie1.play()
	queue_free()
