extends CanvasLayer

var pies = 0

func _ready():
	$Pies.text = String(pies)

func _on_ButterChicken_bcPie_collected():
	pies = pies + 1
	_ready()

func _on_MincePie_mincePie_collected():
	pies = pies + 1
	_ready()

func _on_SteaknCheese_scPie_collected():
	pies = pies + 1
	_ready()
