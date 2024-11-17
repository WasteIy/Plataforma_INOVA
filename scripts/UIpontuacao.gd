extends CanvasLayer
class_name UI

var score := 0
@onready var label: Label = $ColorRect/Label

func adicionarPontos():
	score += 1
	label.text = str(score)
