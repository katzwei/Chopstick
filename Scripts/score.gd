extends Control
class_name Score

@onready var score_value_label = %ScoreValueLabel

func update_score(value: int) -> void:
	score_value_label.text = str(value)
