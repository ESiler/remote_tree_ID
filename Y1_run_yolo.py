#import stuff
import torch
from ultralytics import YOLO

#get data
config = input('Enter YAML file, eg ../YOLO_DATASET_TMP/data_config.yaml: ')
results_file = input('Enter results file location, eg ../YOLO_results: ')
project_name = input('Enter a name for this run. This will be the name of your results folder.')

#get model
model_version = input('Enter yolo model path, eg yolo_models/yolov8n.pt: ')

#train model
model = YOLO(model_version)
results = model.train(data=config, 
                      epochs=100, 
                      imgsz=218,
                      project=results_file,
                      name=project_name
                      plots=True
                      )
