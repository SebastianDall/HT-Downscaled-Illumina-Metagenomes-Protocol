library(tidyverse)
library(readxl)

# DNA extraction concentration
dna_conc <- read_excel("examples/dna_concentration/DNA_extraction_concentration.xlsx", skip = 4) %>% 
  select(-`...9`) %>% 
  rename(dna_input = 5)


# DNA input
idot_input_dna <- dna_conc %>% 
  select(WellID, dna_input) %>% 
  filter(!is.na(dna_input)) %>% 
  mutate(`Liqued Name` = paste0("Template", row_number()),
         `Liqued Name` = if_else(WellID == "E12", "H2O",
                                 if_else(WellID == "F12", "PC", `Liqued Name`))) %>% 
  rename(`volume [µL]` = dna_input) %>% 
  filter(WellID != "E12")

# NFW for dilution
idot_input_nfw <- dna_conc %>% 
  select(WellID, `NFW  [µL]`) %>% 
  filter(!is.na(`NFW  [µL]`)) %>% 
  mutate(`Liqued Name` = "H2O") %>% 
  rename(`volume [µL]` = `NFW  [µL]`)

# IDOT input
idot_input <- bind_rows(idot_input_dna, idot_input_nfw) %>% 
  rename(`Target Well` = WellID) %>% 
  mutate(`volume [µL]` = format(round(`volume [µL]`,2), nsmall = 2)) %>% 
  filter(`volume [µL]` != "0.00")

# idot csv template
idot_template_head <- read_csv("files/idot_CSV_dilution_template.csv", col_names = F, n_max = 3)

idot_template_target <- read_csv("files/idot_CSV_dilution_template.csv", skip = 3, locale=locale(encoding="latin1"), col_types = "ccdcccc") %>% 
  select(-`volume [µL]`) %>% 
  filter(row_number() != 93)


idot_target <- left_join(idot_input, idot_template_target, by = c("Target Well", "Liqued Name")) %>% 
  relocate(`Source Well`)


coln <- colnames(idot_target)
coln <- gsub("\\.{3}\\d+", NA, coln)
idot_target <- rbind(coln, idot_target)

colnames(idot_target) <- paste0("X", 1:7)


idot_file <- bind_rows(idot_template_head, idot_target)

write_delim(idot_file, "examples/idot/idot_csv_dilution.csv", delim=",", col_names = F)

## Test

#idot_example <- read_csv("examples/idot/EXT00105_idot_csv_dilution_template.csv", col_names = F, locale = locale(encoding="latin1"))

#all(idot_example == idot_file, na.rm = T)
