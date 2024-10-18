## NOTE: need to add year variable ....

## assumes the following files are in your current working directory:
##  "P_ALB_CR.XPT" "P_ALQ.XPT"    "P_BIOPRO.XPT" "P_BMX.XPT"    "P_BPQ.XPT"
##  "P_BPXO.XPT"   "P_DBQ.XPT"    "P_DEMO.XPT"   "P_DIQ.XPT"    "P_DR1TOT.XPT"
##  "P_DSQIDS.XPT" "P_DSQTOT.XPT" "P_GLU.XPT"    "P_KIQ_U.XPT"  "P_MCQ.XPT"
##  "P_PAQ.XPT"    "P_RXQ_RX.XPT" "P_SLQ.XPT"    "P_SMQ.XPT"    "P_SMQFAM.XPT"
##  "P_UCFLOW.XPT" "P_UM.XPT"

# install.packages("haven")
# install.packages("dplyr")
# install.packages("purrr")
library(haven)
library(dplyr)
library(purrr)

# full join all tables
xpt_files <- list.files(pattern = "\\.XPT$")
single_tables <- lapply(xpt_files, read_xpt)
merged_df <- reduce(single_tables, full_join, by = "SEQN")

# demographic
p_demo <- c("RIAGENDR", "RIDAGEYR", "RIDRETH3", "INDFMPIR", "DMDEDUC2", "DMDMARTZ")

# dietary
p_dr1tot <- c("DBQ095Z", "DBD100", "DRQSPREP")
p_dr1tot_range1 <- c("DR1TKCAL", "DR1TP226")
p_dr1tot_range2 <- c("DR1_320Z", "DR1TWSZ")
p_dsqids <- c("DSDANTA", "DSD128V", "DSD128FF")
p_dsqtot <- c("DSQTKCAL")

# examination
p_bmx <- c("BMXBMI")
p_bpxo <- c("BPXOSY1", "BPXOSY2", "BPXOSY3", "BPXODI1", "BPXODI2", "BPXODI3", "BPXOPLS1", "BPXOPLS2", "BPXOPLS3")

# laboratory
p_biopro <- c("LBXSBU", "LBXSCA", "LBXSUA")
p_alb_cr <- c("URDACT")
p_ucflow <- c("URDFLOW1", "URDFLOW2", "URDFLOW3")
p_glu <- c("LBXGLU")
p_um <- c("URXUPB")

# questionnaire
p_bpq <- c("BPQ020", "BPQ080", "BPQ050A")
p_diq <- c("DIQ010", "DIQ050", "DIQ070", "DIQ160")
p_dbq <- c("DBD895", "DBD900", "DBD905", "DBD910", "DBQ700")
p_kiq_u <- c("KIQ022", "KIQ026", "KIQ005", "KIQ010", "KIQ042", "KIQ044", "KIQ046", "KIQ480")
p_mcq <- c("MCQ080", "MCQ160M", "MCQ520", "MCQ550", "MCQ366A", "MCQ366B", "MCQ366C", "MCQ366D", "MCQ160L", "MCQ300C")
p_paq <- c("PAQ605", "PAQ620", "PAQ635", "PAQ650", "PAQ665", "PAD680")
p_smq <- c("SMQ020", "SMQ040")
p_smqfam <- c("SMD460", "SMD470")
p_alq <- c("ALQ130")
p_slq <- c("SLQ050")
p_rxq_rx <- c("RXDDAYS", "RXDCOUNT")

named_cols <- c(
    p_demo, p_dr1tot, p_dsqids, p_dsqtot, p_bmx, p_bpxo, p_biopro,
    p_alb_cr, p_ucflow, p_glu, p_um, p_bpq, p_diq, p_dbq, p_kiq_u,
    p_mcq, p_paq, p_smq, p_smqfam, p_alq, p_slq, p_rxq_rx
)

# select cols, remove all rows with NA for the label (KIQ026), keep distinct rows only
df <- merged_df %>%
    select(
        "SEQN",
        all_of(named_cols),
        which(colnames(merged_df) == p_dr1tot_range1[1]):which(colnames(merged_df) == p_dr1tot_range1[2]),
        which(colnames(merged_df) == p_dr1tot_range2[1]):which(colnames(merged_df) == p_dr1tot_range2[2])
    ) %>%
    filter(!is.na(KIQ026)) %>%
    filter(KIQ026 != 9) %>%
    distinct(SEQN, .keep_all = TRUE)

# save csv to current directory
write.csv(df, "merged_data_clean.csv", row.names = FALSE)
