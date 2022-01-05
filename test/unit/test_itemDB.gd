extends "res://addons/gut/test.gd"
func before_each():
	gut.p("ran setup", 2)

func after_each():
	gut.p("ran teardown", 2)

func before_all():
	gut.p("ran run setup", 2)

func after_all():
	gut.p("ran run teardown", 2)

func test_item_import():
	var item_name
	var rand_val = randi() % 3
	if rand_val == 0:
		item_name = "Copper Pickaxe"
	elif rand_val == 2:
		item_name = "Copper Axe"
	else:
		item_name = "Copper Ore"
		
	assert_true(ItemImporter.item_data.has(item_name), "Item DB parsed and imported items")


