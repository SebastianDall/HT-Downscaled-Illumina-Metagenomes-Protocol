library(tidyverse)
library(readxl)

# lib extraction concentration
lib_conc <- read_excel("examples/dna_concentration/library_concentration.xlsx", skip = 10) %>% 
  rename(pool_ng=`...7`) %>% 
  filter(row_number() <= 94)


# DNA input
idot_input_dna <- lib_conc %>% 
  select(WellID, Vsample) %>% 
  filter(!is.na(Vsample)) %>% 
  rename(`volume [µL]` = Vsample,
         `Source Well` = WellID) %>% 
  mutate(`Liqued Name` = paste0("Metagenome",row_number())) %>% 
  mutate(`volume [µL]` = as.character(round(`volume [µL]`,2)))

# idot csv template
idot_template_head <- read_delim("files/idot_pooling_template.csv", col_names = F, n_max = 3, delim = ";")

idot_template_target <- read_delim("files/idot_pooling_template.csv", skip = 3, locale=locale(encoding="latin1"), col_types = "ccdcccc", delim = ";") %>% 
  select(-`volume [µL]`)


idot_target <- left_join(idot_input_dna, idot_template_target) %>% 
  relocate(`Target Well`, .after = `Source Well`)


coln <- colnames(idot_target)
coln <- gsub("\\.{3}\\d+", NA, coln)
idot_target <- rbind(coln, idot_target)

colnames(idot_target) <- paste0("X", 1:7)


idot_file <- bind_rows(idot_template_head, idot_target)

write_delim(idot_file, "examples/idot/idot_pooling.csv", delim=",", col_names = F)

## Test

#idot_example <- read_csv("examples/idot/LIB00105_idot_pooling_template.csv", col_names = F, locale = locale(encoding="latin1"))

#all(idot_example[,c(1,3,4)] == idot_file[,c(1,3,4)], na.rm = T)
