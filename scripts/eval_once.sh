#!/bin/bash

export GPUID=0
export NET="squeezeSeg"
export IMAGE_SET="val"
export LOG_DIR="./log"
export CHECKPOINT_NUM="49999"
export TRAIN_DIR="$LOG_DIR/train"
export CHECKPOINT_PATH="$TRAIN_DIR/model.ckpt-$CHECKPOINT_NUM"

if [ $# -eq 0 ]
then
  echo "Usage: ./scripts/eval.sh [options]"
  echo " "
  echo "options:"
  echo "-h, --help                show brief help"
  echo "-gpu                      gpu id"
  echo "-image_set                (train|val)"
  echo "-log_dir                  Where to load models and save logs."
  echo "-checkpoint_num           Which checkpoint to evaluate."
  echo "-checkpoint_path          Which checkpoint to evaluate."
  exit 0
fi

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "Usage: ./scripts/train.sh [options]"
      echo " "
      echo "options:"
      echo "-h, --help                show brief help"
      echo "-gpu                      gpu id"
      echo "-image_set                (train|val)"
      echo "-log_dir                  Where to load models and save logs."
      echo "-checkpoint_num           Which checkpoint to evaluate."
      echo "-checkpoint_path          Which checkpoint to evaluate."
      exit 0
      ;;
    -gpu)
      export GPUID="$2"
      shift
      shift
      ;;
    -image_set)
      export IMAGE_SET="$2"
      shift
      shift
      ;;
    -log_dir)
      export LOG_DIR="$2"
      shift
      shift
      ;;
    -checkpoint_num)
      export CHECKPOINT_NUM="$2"
      export CHECKPOINT_PATH="$TRAIN_DIR/model.ckpt-$CHECKPOINT_NUM"
      shift
      shift
      ;;
    -checkpoint_path)
      export CHECKPOINT_PATH="$2"
      shift
      shift
      ;;
    *)
      break
      ;;
  esac
done

valdir="$logdir/eval_$IMAGE_SET"

python ./src/eval.py \
  --dataset=KITTI \
  --data_splits_path=./data \
  --data_path=../../data \
  --image_set=$IMAGE_SET \
  --eval_dir="$valdir" \
  --run_once="True" \
  --checkpoint_path="$CHECKPOINT_PATH" \
  --net=$NET \
  --gpu=$GPUID

