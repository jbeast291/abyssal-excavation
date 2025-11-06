@tool
extends EditorPlugin

var dropdown

func _enter_tree():
	dropdown = OptionButton.new()
	dropdown.add_item("Debug")
	dropdown.add_item("QA")
	dropdown.add_item("Release")
	dropdown.connect("item_selected", Callable(self, "_on_option_selected"))
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, dropdown)

func _on_option_selected(index):
	var mode = dropdown.get_item_text(index)
	ProjectSettings.set_setting("custom/run_mode", mode)
	print("Switched to", mode)
