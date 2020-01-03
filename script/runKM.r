# run KM survival analysis

# Input tab-delimited file should contain followin information and was generated by running dataPrepare.sh

# OS. Overall survival status "0" and "1" represents "alive" and "dead" resepctively

# OS.time. Overall survival time in days

# radiation_thearpy. "0" and "1" represents "YES" and "NO" respectively

# PDHA1. PDHA1 gene expression level "1" and "2" represents "high" and "low" respectively

library(survival)

library(survminer)

STAD.survival <- read.delim("STAD.survival.tsv", row.names = 1, header = TRUE)

# KM extimate for radiation_thearpy only

STAD.radiation_therapy <- survfit(Surv(OS.time, OS) ~ radiation_therapy, data = STAD.survival)

ggsurvplot(
	STAD.radiation_therapy,
	pval = TRUE, conf.int = TRUE, conf.int.style = "step", xlab = "Time in days", ggtheme = theme_light(),
	risk.table = "absolute", risk.table.y.text.col = T, risk.table.y.text = FALSE, risk.table.col = "strata",
	ncensor.plot = FALSE, surv.median.line = "none", legend.labs = c("Radiation", "noRadiation"), palette = c("black", "red") 						
)

# KM estimate for PDHA1 expression only

STAD.PDHA1 <- survfit(Surv(OS.time, OS) ~ PDHA1, data = STAD.survival)

ggsurvplot(
	STAD.PDHA1,
	pval = TRUE, conf.int = TRUE, conf.int.style = "step", xlab = "Time in days", ggtheme = theme_light(),
	risk.table = "absolute", risk.table.y.text.col = T, risk.table.y.text = FALSE, risk.table.col = "strata",
	ncensor.plot = FALSE, surv.median.line = "none", legend.labs = c("low_expression", "high_expression"), palette = c("black", "red") 						
)

# KM estimate for both PDHA1 expression and radiation_thearpy

STAD.PDHA1_radiation <- survfit(Surv(OS.time, OS) ~ PDHA1 + radiation_therapy, data = STAD.survival[STAD.survival$radiation_therapy == '0', ])

ggsurvplot(
	STAD.PDHA1_radiation,
	pval = TRUE, conf.int = TRUE, conf.int.style = "step", xlab = "Time in days", ggtheme = theme_bw(),
	risk.table = "absolute", risk.table.y.text.col = T, risk.table.y.text = FALSE, risk.table.col = "strata",
	ncensor.plot = FALSE, surv.median.line = "none",
	legend.labs = c("low_expression_radiation", "high_expression_radiation"), palette = c("black", "red")
)

STAD.PDHA1_no_radiation <- survfit(Surv(OS.time, OS) ~ PDHA1 + radiation_therapy, data = STAD.survival[STAD.survival$radiation_therapy == '1', ])

ggsurvplot(
	STAD.PDHA1_no_radiation,
	pval = TRUE, conf.int = TRUE, conf.int.style = "step", xlab = "Time in days", ggtheme = theme_bw(),
	risk.table = "absolute", risk.table.y.text.col = T, risk.table.y.text = FALSE, risk.table.col = "strata",
	ncensor.plot = FALSE, surv.median.line = "none",
	legend.labs = c("low_expression_no_radiation", "high_expression_no_radiation"), palette = c("black", "red")
)
