@echo off

cd PGDiff
call .\venv\Scripts\activate.bat

set CUDA_VISIBLE_DEVICES=0
python inference_pgdiff.py --task restoration --in_dir testdata/cropped_faces --out_dir results/blind_restoration --guidance_scale 0.05
pause
