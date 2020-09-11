library(tidyverse)
library(Biostrings)
library(taxonomizr)
sql_db <- "/GWSPH/home/bnguyen/taxonomizr_db/accessionTaxa.sql"
#midori_COI_longest <- readDNAStringSet("./MIDORI_LONGEST_20180221_COI.fasta")
midori_COI_unique <- readDNAStringSet("MIDORI_UNIQ_GB239_CO1_RAW.fasta")

#accnos_longest <- str_extract(names(midori_COI_longest), "[A-Z0-9]*\\.[^.]+")
accnos_unique <- str_extract(names(midori_COI_unique), "[A-Z0-9]*\\.[^.]+")

#orig_names_longest <- str_extract(names(midori_COI_longest), "[^\t]*")
orig_names_unique <- str_extract(names(midori_COI_unique), "[^\t]*")

#getNamesAndNodes()
#getAccession2taxid()
#read.accession2taxid(list.files('.','accession2taxid.gz$'), 'accessionTaxa.sql')
#taxaNodes <- read.nodes("nodes.dmp")
#taxaNames <- read.names("names.dmp")


#COI_longest_taxaIds <- accessionToTaxa(accnos_longest, "./accessionTaxa.sql")
COI_unique_taxaIds <- accessionToTaxa(accnos_unique, sql_db)

#COI_longest_lineages <- getTaxonomy(COI_longest_taxaIds, taxaNodes, taxaNames, desiredTaxa = c("superkingdom", "kingdom","phylum", "class", "order", "family", "genus", "species"), mc.cores = parallel::detectCores())
COI_unique_lineages <- getTaxonomy(COI_unique_taxaIds, sql_db, desiredTaxa = c("superkingdom", "kingdom","phylum", "class", "order", "family", "genus", "species"), mc.cores = parallel::detectCores())

#longest.tax.df <- as.data.frame(COI_longest_lineages, rownames = orig_names_longest)
unique.tax.df <- as.data.frame(COI_unique_lineages, rownames = orig_names_unique)

#new_names_midori_longest <- as.character(paste0(orig_names_longest, "\t", longest.tax.df$superkingdom, ";", longest.tax.df$kingdom, ";", longest.tax.df$class, ";", longest.tax.df$order, ";", longest.tax.df$family, ";", longest.tax.df$genus, ";", longest.tax.df$species))

new_names_midori_unique <- as.character(paste0(orig_names_unique, "\t", unique.tax.df$superkingdom, ";", unique.tax.df$kingdom, ";", unique.tax.df$class, ";", unique.tax.df$order, ";", unique.tax.df$family, ";", unique.tax.df$genus, ";", unique.tax.df$species))

#names(midori_COI_longest) <- new_names_midori_longest
names(midori_COI_unique) <- new_names_midori_unique

#writeXStringSet(midori_COI_longest, "./MIDORI_LONGEST_20180221_COI_reformatted.fasta", format = "fasta")
writeXStringSet(midori_COI_unique, "./MIDORI_UNIQ_GB239_CO1_DECIPHER.fasta", format = "fasta")
