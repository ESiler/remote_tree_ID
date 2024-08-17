#!/bin/bash

echo "Welcome to this YOLO file shuffling script!"

echo "Which plot labels are you using? eg 1_cat, 2_conifer_cat, 11_genius_cat: "
read label_set

echo "What are your training zones (eg zone_A, zone_B, etc.)? Enter your training zones separated by spaces: "
read train_zone

echo "What are your validation zones(eg zone_A, zone_B)? Enter your validation zones separated by spaces: "
read val_zone


# Label directories
source_dir_l="../../../Plot_Labels/${label_set}"
destination_l_t="../YOLO_DATASET_TMP/labels/train"
destination_l_v="../YOLO_DATASET_TMP/labels/val"

# Image directories
source_dir_p="../../../Plot_Images/train"
destination_p_t="../YOLO_DATASET_TMP/images/train"
destination_p_v="../YOLO_DATASET_TMP/images/val"


# Delete all files in the destination directories before creating new symlinks
rm -f ${destination_l_t}/*
rm -f ${destination_l_v}/*
rm -f ${destination_p_t}/*
rm -f ${destination_p_v}/*

#For each training zone:
for z in ${train_zone[@]}
do
# Create symlinks for each line in the training zone file
    while IFS= read -r line
    do
      # Construct the source and destination file paths for training labels
      source_file="${source_dir_l}/${line}.txt"
      destination_file="${destination_l_t}/${line}.txt"
      # Create the symlink for training labels
      ln -s "$source_file" "$destination_file"

      # Construct the source and destination file paths for training images
      source_image="${source_dir_p}/${line}.png"  
      destination_image="${destination_p_t}/${line}.png"
      # Create the symlink for training images
      ln -s "$source_image" "$destination_image"
    done < "../Zone_Plots/$z.txt"
done

#For each validation zone:
for z in ${val_zone[@]}
do
    # Create symlinks for each line in the validation zone file
    while IFS= read -r line
    do
      # Construct the source and destination file paths for validation labels
      source_file="${source_dir_l}/${line}.txt"
      destination_file="${destination_l_v}/${line}.txt"
      # Create the symlink for validation labels
      ln -s "$source_file" "$destination_file"

      # Construct the source and destination file paths for validation images
      source_image="${source_dir_p}/${line}.png" 
      destination_image="${destination_p_v}/${line}.png"
      # Create the symlink for validation images
      ln -s "$source_image" "$destination_image"
    done < "../Zone_Plots/$z.txt"
done

echo "Thanks! Your training zones are $train_zone and your validation zones are $val_zone"
echo "Your data has been prepped to run YOLO! Please verify that your symlinks work before proceeding."


