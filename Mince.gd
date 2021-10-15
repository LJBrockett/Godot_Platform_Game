extends Area2D

signal mincePie_collected


func _ready():
	$AnimatedSprite.play("Idle")


func _on_MincePie_body_entered(body):
	emit_signal("mincePie_collected")
	$SoundPie2
	queue_free()
