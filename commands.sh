python scripts/train.sh -gpu 0 -image_set train -log_dir ./log/
python scripts/eval_once.sh -gpu 0 -image_set val -log_dir ./logSqueezeSeg -checkpoint_path ./data/SqueezeSegV2/model.ckpt-30700
python scripts/eval_once.sh -gpu 0 -image_set val
