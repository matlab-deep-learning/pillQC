# PillQC

This repository provides a dataset to demonstrate visual inspection and quality control related to pill manufacturing. The dataset contains three classes of images: normal pills which are free of defects, pills with dirt contamination, and pills with a chip defect. 

<img src="images/normal/normal0001.jpg?raw=true">
<img src="images/dirt/dirt0001.jpg?raw=true"> 
<img src="images/chip/chip0001.jpg?raw=true"> 

## Anomaly Detection Example
This repository provides a MATLAB example as a Live Script which is based on the approach described in Explainable Deep One-Class Classification by Liznerski et al. The example shows how a deep anomaly detector can be trained on normal image data, together with a very small amount of anomaly data, to create a very effective pill anomaly detector. Running the included example requires MATLAB and the Deep Learning Toolbox. 

```
@inproceedings{
    liznerski2021explainable,
    title={Explainable Deep One-Class Classification},
    author={Philipp Liznerski and Lukas Ruff and Robert A. Vandermeulen and Billy Joe Franks and Marius Kloft and Klaus-Robert M{\"u}ller},
    booktitle={International Conference on Learning Representations},
    year={2021},
    url={https://openreview.net/forum?id=A5VV3UyIQz}
}
```

# License

The license used in this contribution is the XSLA license, which is the most common license for MathWorks staff contributions.
