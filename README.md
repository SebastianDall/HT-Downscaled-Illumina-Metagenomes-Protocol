# HT Downscaled Illumina Metagenomes Protocol

This repository contains the layouts and csv-files used in the HT downscaled Illumina Metagenomes Protocol described in **ATICLE**.

## Equipment and consumables
- I-DOT one
    + S.100 source plate
    + PUREPlate 200 wells
- PCR target plates
- epMotion:R:96
    + epMotion tips
- Illumina DNA prep and IDT UD barcodes
- Eppendorf electronic multipipette


## Plate layouts
This protocol is a step-by-step guide for making metagenomes in a high-throughput setting using a 1:10 downscaled version of the Illumina DNA prep kit.

### DNA extraction plate
The first step is to create a 3 ul reaction volume with 20 ng of DNA or less, based on the DNA extraction concentration. The layout of the DNA extraction plate is as follows:

<img src="figures/DNA_extraction_plate.png" alt="drawing" width=1000/>

To perform dilution with the I-DOT one a CSV file needs to be provided with the required DNA input amount from each well and dilution amount. The `files/dna_extraction_concentration.xlsx` calculates the required DNA input and and dilution volume based on the DNA extraction concentration, which is the input to creating the `files/idot_CSV_dilution_template.csv`.

### DNA dilution source plate
The layout of the source plate is as follows:

<img src="figures/metagenome_source_plate.png" alt="drawing" width=1000/>

The source plate has 3 wells with NFW, E12, G12, and H12, which are used to dilute all other samples. Thus if well A1 requires 2 ul sample for a 20 ng DNA input, 1 ul NFW will be added from one of the dilution wells.

### DNA target plate
The layout of the target plate after addition of sample and NFW is as follows:

<img src="figures/metagenome_target_plate.png" alt="drawing" width=1000/>

Each well contains a 3 ul reaction volume.



## Protocol
### Tagementation
- Copy data from the `files/DNA_extraction_concentration.xlsx` and fill out the CSV template – `files/idot_CSV_dilution_template.csv`.
- Delete all rows containing 0 µL.
- Load 10 µL sample onto a S.100 source plate using the EP-motion (grey tips).
- Add 7 µl PCR positive control in F12
- Add 80 µL NFW to the dilution wells; E12, G12, H12.
- Place the source plate and PCR target plate in the I-DOT and run the `files/idot_CSV_dilution_template.csv`.
- After dilution, remove the source plate, and clean the underside of the source tray with ethanol solution.
- Prepare the BLT/TB1 mastermix and add 51.7 ul to four PUREplate200 source jets (A1-D1) in a source plate.
- Place the BLT/TB1 source plate in the I-DOT and run the `files/BLT_TB1_additions.idot` file. This will add 2 ul BLT/TB1.
- Remove the `DNA target plate` from the I-DOT
    + Foil the plate, vortex, and briefly spin (Henceforth referred to as FVS)
- Place in a thermocycler and run the TAG programme

<img src="figures/tag_programme.png" alt="drawing" width=500/>




