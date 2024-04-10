![image](https://github.com/ObjectVision/GLOBIO_dms/assets/96182097/1a7d2141-76e7-49cf-866b-9490d5a3099a)
# GLOBIO
This repository provides GLOBIO functionality using GeoDMS for **landuse allocation** and **spatial aggregation**. 

## Setup
<details>
<summary><b>GeoDMS software</b></summary>
<p>Open source Geographic Data & Model Software (GeoDMS) is actively being developed to create (geographical explicit) planning support systems. For installation of GeoDMS navigate to the <a href="https://github.com/ObjectVision/GeoDMS/releases">releases</a> page of <a href="https://github.com/ObjectVision/GeoDMS">GeoDMS</a> and follow the steps of the downloaded installer. </p>
</details>

<details>
<summary><b>Source data</b></summary>
  <p>
    The following source data files are expected for the landuse allocation module:
    <ol>
      <li><b>Claim1970.csv</b> (see <a href="https://github.com/ObjectVision/GLOBIO_dms/blob/main/data/Claim1970.csv">data/Claim1970.csv</a>)):  claims per landuse class per IMAGE region for the complete sets of landuse classes and IMAGE regions</li>
      <li><b>ESA_IMAGEregions_10sec_no_water_GLOBIO41cz.tif</b>: tif file with IMAGE regions</li>
      <li><b>ESACCI_GLOBIO_1992_water1992-2015.tif</b>: ESA landuse map</li>
      <li><b>GFERTILIZER_1970.tif</b>: Fertilizer usage intensity map</li>
      <li><b>not_allocatable_ESA-CCI_1992-2015.tif</b>: Boolean map of land, no land</li>
      <li><b>pa_reduce_factor_wdpa_2018_july.tif</b>: Map with excluded areas of allocation</li>
      <li><b>Regions.csv</b> (see <a href="https://github.com/ObjectVision/GLOBIO_dms/blob/main/data/Claim1970.csv">data/Regions.csv</a>): csv file with fields: Region;Nr;Countries for example Ukraine region;14;Belarus (112), Moldova (498), Ukraine (804) </li>
      <li><b>suit_crop_lu_diff_no_wtr_ice_0.tif</b>: Cropland suitability map</li>
      <li><b>suit_forestry_2015.tif</b>: Forestry suitability map</li>
      <li><b>suit_pasture_lu_diff_no_wtr.tif</b>: Pasture suitability map</li>
      <li><b>suit_urban.tif</b>: Urban suitability map</li>
    </ol> 
  </p>
</details>

## Landuse allocation
Landuse allocation in this project can either be calculated per region or for the world in one go. The algorithm goes over landuse types in the parameter: LandusePriorityCodes order, sorts the suitability map in descending order, aggregates the per cell area up to the claim and assigns these cells to the claimed landuse.
 
The world allocation can be written to file using item: **/Allocation/world/MakeGrid/RESULT**

The per region allocation can be written to file using for instance Western-Europe item: **/Allocation/per_region/Western_Europe/MakeGrid/RESULT**

## Spatial aggregation

## Python
See [examples/example_01_run_dms_globio_alloc.py](https://github.com/ObjectVision/GLOBIO_dms/blob/main/examples/example_01_run_dms_globio_alloc.py) for how to call the configuration from Python as is, showing only how to change the InDir and OutDir parameters.

See See [examples/example_02_run_dms_globio_alloc_change_param.py](https://github.com/ObjectVision/GLOBIO_dms/blob/main/examples/example_02_run_dms_globio_alloc_change_param.py) for how to call the configuration from Python as is, showing only how to change the InDir and OutDir parameters.
