extends Panel
@onready var button = $Button
@onready var souvenirs = $"."
@onready var rich_text_label = $RichTextLabel

func _on_button_pressed():
	souvenirs.visible = false

func show_journal_texts(journal_texts: Array):
	rich_text_label.clear()
	for text in journal_texts:
		rich_text_label.append_text(text + "\n\n")

func _on_visibility_changed():
	show_journal_texts(Data.get_journal())
