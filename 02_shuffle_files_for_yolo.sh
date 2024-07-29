#!/bin/bash

echo "Welcome to this YOLO file shuffling script!"

echo "What is your training zones? Enter zone_A, zone_B, etc."
read train_zone

echo "What is your validation zone? Enter zone_A, zone_B, etc."
read val_zone

# Training labels
source_dir_l="../../../Plot_Labels/train"
destination_l_t="../YOLO_DATASET_TMP/labels/train"

# Training images
source_dir_p="../../../Plot_Images/train"
destination_p_t="../YOLO_DATASET_TMP/images/train"

# Validation labels
source_dir_l_v="../../../Plot_Labels/train"
destination_l_v="../YOLO_DATASET_TMP/labels/val"

# Validation images
source_dir_p_v="../../../Plot_Images/train"
destination_p_v="../YOLO_DATASET_TMP/images/val"

# Delete all files in the destination directories before creating new symlinks
rm -f ${destination_l_t}/*
rm -f ${destination_l_v}/*
rm -f ${destination_p_t}/*
rm -f ${destination_p_v}/*

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
done < "../Zone_Plots/${train_zone}.txt"

# Create symlinks for each line in the validation zone file
while IFS= read -r line
do
  # Construct the source and destination file paths for validation labels
  source_file="${source_dir_l_v}/${line}.txt"
  destination_file="${destination_l_v}/${line}.txt"
  # Create the symlink for validation labels
  ln -s "$source_file" "$destination_file"

  # Construct the source and destination file paths for validation images
  source_image="${source_dir_p_v}/${line}.png" 
  destination_image="${destination_p_v}/${line}.png"
  # Create the symlink for validation images
  ln -s "$source_image" "$destination_image"
done < "../Zone_Plots/${val_zone}.txt"

echo "Thanks! Your training zone is $train_zone and your validation zone is $val_zone"


