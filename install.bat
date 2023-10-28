@echo off

@echo off
git clone https://github.com/pq-yang/PGDiff
cd PGDiff



echo PGDIFF venv
IF NOT EXIST venv (
    "C:\python38\python.exe" -m venv venv
) ELSE (
    echo venv folder already exists, skipping making new venv...
)
call .\venv\Scripts\activate.bat

pip install gdown
pip install blobfile==1.0.6
pip install mpi4py
pip install -r requirements.txt
pip install -e .

pip uninstall torch torchvision torchaudio --yes
pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu118

echo downloading models

set "storageFolder=models"
set "storageFolderSub=models/restorer"

REM Tạo thư mục lưu trữ (nếu chưa tồn tại)
mkdir "%storageFolder%"
mkdir "%storageFolderSub%"

REM Chạy mã Python để tải xuống tệp và di chuyển nó vào thư mục lưu trữ
python -c "import gdown; import os; url = 'https://drive.google.com/uc?id=1kfpLl4JsGxa_8GQXhzt8t38f5tR62uXW'; output = 'iddpm_ffhq512_ema500000.pth'; gdown.download(url, output, quiet=False); os.rename(output, os.path.join('%storageFolder%', output))"
python -c "import gdown; import os; url = 'https://drive.google.com/uc?id=13qG5ScClpmmMNndhsYeWqZx58p1h01EO'; output = 'rrdb_iter_100000.pth'; gdown.download(url, output, quiet=False); os.rename(output, os.path.join('%storageFolderSub%', output))"
python -c "import gdown; import os; url = 'https://drive.google.com/uc?id=1YWDPhqxNAtPb7t3ZJhbZ4a_sE8SqVhwX'; output = 'ms1mv3_arcface_r50_fp16.pth'; gdown.download(url, output, quiet=False); os.rename(output, os.path.join('%storageFolderSub%', output))"

REM Display "done" message and prompt the user to press any key
echo Done! Press any key to close the Command Prompt window.
pause > nul

echo Done!!!
