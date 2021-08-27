

conda create -y -n deepfacelab python=3.6.6 cudatoolkit=9.0 cudnn=7.3.1
conda activate deepfacelab
git clone https://github.com/lbfs/DeepFaceLab_Linux.git
cd DeepFaceLab_Linux
python -m pip install -r requirements-cuda.txt
