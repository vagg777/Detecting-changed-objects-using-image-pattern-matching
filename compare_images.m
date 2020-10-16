function [result] = compare_images(initial_image, final_image)

result = imabsdiff(initial_image,final_image); 