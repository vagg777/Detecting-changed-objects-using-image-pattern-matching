# Detecting changed objects using image pattern matching

# 0. Contributors
* Evangelos Michos (and author of this readme file)
* Vasileios Kokkinos

## 1. Introduction
Pattern matching in computer vision refers to a set of computational techniques which enable the localization of a template pattern in a sample image or signal. Such template pattern can be a specific facial feature, an object of known characteristics or a speech pattern such as a word. Many of the challenges in computer vision, signal processing and machine learning can be formulated and solved under the context of pattern matching terminology. An efficient solution to pattern search and matching should consist first in restricting search space to one in which the localization of a best match to a given pattern is not based on a direct comparison of pixel by pixel values of the pattern and sample, but rather it is made on scale-invariant features. The use of these features, e.g. Harris corners or histogram-based matching, partially resolves the scale issue and reduces the matching problem to one for which only very few key points and their descriptors need to be aligned.

In many daily environments (let's take for example, a construction site), risk assessment is crucial. Many areas in a construction site are considered highly dangerous and workers should be extra careful around such areas. What is more important is that workers should be aware of which areas are hazardous and do their best to avoid any injuries around such areas. 

## 2. The idea
This proposal taclkes the issue whete finding differences between two images is crucial (risk assessment included) and allows anyone to compare any two images and find the areas in which the two images are different. Even though the user is free to select any two images he wishes, it makes sense to use similar images in order for the comparison to have a meaningful essence.

The image comparison is enabled by using two different techniques:
1.    Method of areas mask
2.    Method of image scan

The user can create areas of interest (in the first image), which are later on used by the system in order to detect how many and which are the areas that are different in the second image. The resulting output (if the user selects to compare) is a comparison figure between the first and the second input images, highlighting the areas where changes are detected (e.g. a missing object or a changed structure). If requested, the user can also receive an email response, containing the two comparison images, highlighting the changes and a formatted text that includes the most important aspects of the comparison, like the timestamp, the number of detected area changes etc.


Overall, the main features of the system include:
1.    Define an email address
2.    Enable/Disable email support
3.    Select the original image
4.    Define new object area
5.    Delete existing object area
6.    Display current object areas
7.    Risk assessment menu
8.    Compare images with areas mask method
9.    Compare images with image scan method
10.   Display Results

![This is a alt text.](https://i.ibb.co/x1Z9FqS/Screenshot-1.png "Image 1")

*Image 1. The menu options*

## 3. Tools needed

* Project Version : `Final`
* IDE Version : `Matlab`
* Programming Language : `Matlab`
* Matlab Version : `2019b`

## 4. Explaining the functions

* `main.m`: **Run this file to launch the application**. Also hanldes all menu selections.
* `areas_selection_impl.m`: Handles the implementation that allows to define new area by creating the polygon points. 
* `areas_selection.m`: Handles user's response to define new area after already having created an area.
* `assess_risk.m`: Handles implementation and saving data for risk assessment.
* `assess_risk_menu.m`: Creates the menu for the risk assessment options.
* `compare_images.m`: Returns the absolute difference between the two images using MATLAB's `imabsdiff()`.
* `count_risk_areas.m`: Counts the risk areas and saves them in `/risks` folder.
* `create_email_text.m`: Responsible for creating the email text and add the attachments (located in the `/output` folder).
* `display_area_risk_table.m`: Displays the table of hazards (risk schedule, probability, severity, etc)
* `display_areas_impl.m`: Displays all the user defined areas in the original image
* `display_changed_areas_impl.m`: Displays all the defined areas that changed in the original image
* `find_areas_with_changes.m`: Finds the area changes between the two images
* `get_global_properties`: Declares all the global filepaths and variables (e.g. email account)
* `image_compare_tool`: Creates the window that shows the two comparison images side-by-side
* `image_zoom_tool`: Adds a smaller windows to allow zoom in and out in the comparison images
* `include_areas_in_image`: Responsible for adding the user-defined areas in the image
* `save_files`: Saves the initial and the comparison images in the `/images` folder.
* `save_risks_impl`: Saves a new risk/hazard added by the user
* `scan_images_for_changes`: Scans the two images to find the differences.
* `send_email`: Declare the email properties, attach the respective two images from the `/output` folder and send the email.

## 5. Features Overview
### 5.1.  Define an email address

User can define an email address to which he wishes to receive an automated response after comparing the two images. After selecting the `Enter e-mail address` option in the menu, the following pop-up appears.

![This is a alt text.](https://i.ibb.co/tH3Q1DK/Screenshot-2.png "Image 2")

*Image 2. Change the email address*

### 5.2.  Enable/Disable email support

User can either enable or disable email support (receive the comparison result also via email). After selecting the `Enter e-mail` option in the menu, the following pop-up appears.

![This is a alt text.](https://i.ibb.co/bdy9mqC/Screenshot-3.png "Image 3")

*Image 3. Enable or Disable support*

### 5.3.  Select the original image

The first stage of the comparison is to select the prime image (or more simply, the first image). The first image is also the image which we can manage and define new areas or delete existing ones, so that these areas are taken into consideration when applying the second image for comparison. After selecting the `Select original image` option in the menu, the following pop-up appears, where the user select the original image.

![This is a alt text.](https://i.ibb.co/DgStRkL/Screenshot-6.png "Image 4")

*Image 4. Select the first image*

### 5.4.  Define new object area

After having selected the original image, the search area must be then defined. To define a new area, the user may use the cursor to send the points as a polygon and double-press the cursor to end drawing the polygon area. After selecting the `Define new area` option in the menu, the following MATLAB tool opens, allowing the user to draw the new area as desired.


![This is a alt text.](https://i.ibb.co/R224NrF/Screenshot-9.png "Image 5")

*Image 5. Draw new polygon area*

Note that existing drawn areas are surrounded by green margins and are all labeled with a unique id. This means that every newly generated area is automatically assigned a new unique id every time.

### 5.5.  Delete an area

Of course, users should always have the ability to delete existing areas for many reasons (e.g. they made mistakes marking the area, or they changed their minds about how the areas should be shaped). In any case, after selecting the `Delete an area` option in the menu, the user is greeted with a pop-up message, asking to define which area should be deleted.

### 5.6.  Display defined areas

After selecting the `Display defined areas` option in the menu, the system provides a figure that depicts all defined areas (in the original image). Note that for the most demanding features of the system (e.g display areas, compare images), a Progress Bar shows up, notifying the user on how the system is progressing with the task.

![This is a alt text.](https://i.ibb.co/DkCZJys/Screenshot-8.png "Image 6")

*Image 6. Progress Bar to notify user on current progress*

![This is a alt text.](https://i.ibb.co/8BjnWbx/Screenshot-12.png "Image 7")

*Image 7. Display the existing areas*

### 5.7.  Risk assessment menu

After selecting the `Risk assessment menu` option in the menu, the system provides two further option related to risk assessment.

![This is a alt text.](https://i.ibb.co/5F0FgGT/Screenshot-15.png "Image 8")

*Image 8. Risk assessment options*

![This is a alt text.](https://i.ibb.co/LxbJTbZ/Screenshot-16.png "Image 9")

*Image 9. Complete data for risk assessment*

![This is a alt text.](https://i.ibb.co/BC85Qts/Screenshot-14.png "Image 10")

*Image 10. Display the Risk schedule*

### 5.8. Compare images (with areas mask)
If the user selected the `Compare images (with areas mask)` option from the menu, he is prompted to select the second image for the comparison by browsing on his computer (see *Image 4*). After having selected the comparison image, the tool processes the information and implements the comparison by finding the object areas where changes occured. The output looks like this:

![This is a alt text.](https://i.ibb.co/4PfQFrv/Screenshot-19.png "Image 11")

*Image 11. Comparison results using areas mask (from left to right: zoom in-out tool, side-by-side differences, hazards detected in these areas)*

### 5.9. Compare images (with image scan)
If the user selected the `Compare images (with image scan)` option from the menu, he is prompted to select the second image for the comparison by browsing on his computer (see *Image 4*). After having selected the comparison image, the tool processes the information and implements the comparison by finding the object areas where changes occured. The output looks like this (the progress bar:

![This is a alt text.](https://i.ibb.co/Rc7YvFY/Screenshot-21.png "Image 12")

*Image 12. Comparison results using image scan (from left to right: zoom in-out tool, side-by-side differences, hazards detected in these areas)*

### 5.10. Display Results

For any of the existing comparisons so far, both the initial image and the compared images are stored in the tool, so that the user can anytime retrieve the data of a previous comparison. After selecting the `Display Results` option from the menu and selecting the comparison image we are interested with, the following output is provided. 

![This is a alt text.](https://i.ibb.co/17j1NFW/Screenshot-22.png "Image 13")

*Image 13. Display existing comparison results*

### 5.11 System logging (extra)
It goes without saying that such a complex system should incorporate a system logging for all its features. The system logging provides the current timestamp of the action executed and the type of action, as well as supportive information on the system, depending on the action executed.

![This is a alt text.](https://i.ibb.co/HtNHDHn/Screenshot-23.png "Image 14")

*Image 14. System logging*
