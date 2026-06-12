# ORCA2_PY

Test case for hybrid NEMO-Python on dev branch

**Repository content:**
- Repository follows standard structure of a NEMO config
- Script ``deploy.sh`` does fetch the inputs, deploy and compile the config, and init running directory


## 1. Requirements

- Installed OASIS3-MCT v5.0 or later with Python interface
- Installed XIOS with OASIS3-MCT
- Installed [Eophis](https://eophis.readthedocs.io/en/latest/install.html#) package

```
git clone -b v1.1.0 https://github.com/IGE-OPERA/eophis.git eophis_v1.1.0
cd eophis_v1.1.0
pip install .

# Test - requires mpirun command authorized
cd tests
./run_all_tests.sh
```

## 2. Deploy config

- Clone NEMO dev branch

```
git clone -b Fork-12-oasis-interface-for-python-scripts https://forge.nemo-ocean.eu/extdevs/nemo.git nemo
```
  
- Deploy config:

```
cd nemo/cfgs
git clone https://github.com/alexis-barge/ORCA2_PY.git
```

- Arch file template is provided, you might need to adapt it according ot your computing environment

```
cd ORCA2_PY
./deploy.sh
```

## 3. Run test case

```
cd EXP00
for file in ../FORCING/*
do
ln -s $file .
done
```

```
touch namcouple
rm namcouple*
python3 ./main.py --exec preprod
```
```
mpirun -np 5 ./nemo.exe : -np 1 python3 ./main.py
```

- A template submission script ```job.ksh``` is given to run the test on HPC center.
