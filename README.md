cd /media/benpham/WORK/03_WorkSpace/01_SourceCode/14_ML/Wine-Prediction-Model

# 1) Create Python env + install deps

python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
pip install dvc[s3]

# 2) If DVC is not initialized yet

dvc init

# 3) Add dataset to DVC tracking

dvc add data/wine_sample.csv

# 4) Ensure remote is configured (your config already points to S3)

dvc remote list

# optional if you need to set again:

# dvc remote add -d wineremote s3://mlops-dvc-bucket

# 5) Push data file to S3 remote

dvc push

# 6) Pull data from remote on another machine (or after fresh clone)

dvc pull

If you only want one file:
dvc pull data/wine_sample.csv.dvc

# Show DVC-tracked files status

dvc status

# Reproduce pipeline (if you create dvc.yaml stages later)

dvc repro

# Check where cached data/artifacts are stored

dvc doctor

git add .gitignore data/wine_sample.csv.dvc .dvc/config
git commit -m "Track wine dataset with DVC and configure S3 remote"
