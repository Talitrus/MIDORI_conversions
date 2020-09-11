#!/usr/bin/env Rscript


# Setup ------------------
library("taxonomizr")

# Taxonomizr prep ----------------------------
#prepareDatabase('accessionTaxa.sql')
#assume database already prepared
sql_db <- "/GWSPH/home/bnguyen/taxonomizr_db/accessionTaxa.sql"
accnos <- scan(file = "midori_blca/midori_accnos.txt", what = character())
accnos.1 <- paste0(accnos, ".1")
taxaIds <- accessionToTaxa(accnos.1, sql_db)

# Including the kingdom level here. Can we get BLCA to work with a kingdom level?
lineages <- getTaxonomy(taxaIds, sql_db, desiredTaxa = c("superkingdom", "kingdom","phylum", "class", "order", "family", "genus", "species"), mc.cores = parallel::detectCores())
tax.df <- as.data.frame(lineages, row.names = accnos)
tax.df$taxID <- taxaIds

uniq.tax.df <- tax.df[unique(row.names(tax.df)),]
zz <- file("midori_blca/midori_kingdom_blca_taxonomy.txt", "w")
for (xi in 1:nrow(uniq.tax.df)) {
  writeLines(as.character(paste0(rownames(tax.df)[xi], "\t", "species:", tax.df$species[xi], ";genus:", tax.df$genus[xi], ";family:", tax.df$family[xi], ";order:", tax.df$order[xi], ";class:", tax.df$class[xi], ";phylum:", tax.df$phylum[xi], ";kingdom:", tax.df$kingdom[xi], ";superkingdom:", tax.df$superkingdom[xi],';')), con = zz)
}

close(zz)
