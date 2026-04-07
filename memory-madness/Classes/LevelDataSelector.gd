extends Node

class_name LevelDataSelector

func get_images_for_level(level_setting: LevelSetting) -> Array[Texture2D]:
	ImageManager.shuffle_images()
	
	# now pick a total of target_pairs (num pairs) images
	var selected_image_array: Array[Texture2D] = []
	
	#while (selected_image_array.size() != level_setting.target_pairs):
		## keep selecting images until we hit the number we want
		#var selected_image: Texture2D =  ImageManager.get_random_item_image()
		#if !(selected_image in selected_image_array):
			#
			## we add 2 images (so that it can be a pair) in the array 
			#selected_image_array.append(selected_image)
			#selected_image_array.append(selected_image)
	
	for i in range(level_setting.target_pairs):
		selected_image_array.append(ImageManager.get_image_at_index(i))
		selected_image_array.append(ImageManager.get_image_at_index(i))
		# note: we won't get the same image since we get each image here from the index i 
		# and we use i only once per iteration
	
	# shuffle the selected image array to make the games unpredictable
	selected_image_array.shuffle()
	
	return selected_image_array
