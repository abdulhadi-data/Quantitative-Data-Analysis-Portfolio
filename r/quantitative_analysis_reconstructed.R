# Quantitative Data Analysis Portfolio
# Reconstructed R analysis snippets based on commands and outputs shown in the portfolio report.
# This is not the original complete coursework script.

# -----------------------------
# Non-parametric hypothesis tests
# -----------------------------

# Chi-squared test
chisq.test(mytable)

# Chi-squared test using Monte Carlo simulation
chisq.test(mytable, simulate.p.value = TRUE, B = 2000)

# Wilcoxon signed-rank test
wilcox.test(AandE$male, AandE$female, paired = TRUE)

# Mann-Whitney U / Wilcoxon rank-sum test
wilcox.test(total ~ in_out, data = AandE)

# Proportional male vs female attendance
wilcox.test(AandE$pMale, AandE$pFemale, paired = TRUE)

# Proportional total A&E attendance by Inner/Outer London
wilcox.test(pTotal ~ in_out, data = AandE)


# -----------------------------
# Parametric tests and ANOVA
# -----------------------------

# One-sample Kolmogorov-Smirnov test
ks.test(blood.tests$p.diff, "pnorm",
        mean = mean(blood.tests$p.diff),
        sd = sd(blood.tests$p.diff))

# One-sample t-test
t.test(blood.tests$p.diff, mu = 0)

# One-way ANOVA
fit1 <- aov(ed_exp ~ council, data = Johnston.80)
summary(fit1)

# Tukey HSD
TukeyHSD(fit1)

# Two-factor ANOVA
fit2 <- aov(ed_exp ~ council + eng_wal, data = Johnston.80)
summary(fit2)

# Kruskal-Wallis tests
kruskal.test(ed_exp ~ council, data = Johnston.80)
kruskal.test(ed_exp ~ eng_wal, data = Johnston.80)


# -----------------------------
# Correlation, PCA and clustering
# -----------------------------

# Example Spearman correlation
cor.test(Deprivation, Life_Male, method = "spearman")

# Partial correlations shown in the report
# Requires ppcor package
pcor.test(Life_Male, Crime, Greenspace)
pcor.test(Life_Male, Greenspace, Crime)

# Hierarchical clustering
# The report shows Ward.D and complete-linkage clustering.
# Example structure:
# d <- dist(scale(cluster_data))
# hc <- hclust(d, method = "ward.D")
# plot(hc)

# K-means clustering
# Example structure:
# set.seed(123)
# km <- kmeans(scale(cluster_data), centers = 4)
# plot(km)


# -----------------------------
# Regression modelling
# -----------------------------

# Simple regression: male life expectancy vs deprivation
model1 <- lm(Life_Male ~ Deprivation)
summary(model1)

# Full multiple regression model
model2 <- lm(
  Life_Male ~ Dom_Build + NonDom_Build + Dom_Gardens +
    Greenspace + Smoking + Binge_Drink + Obese +
    Episodes + Benefits + Crime
)
summary(model2)

# Reduced model using component-related variables
model3 <- lm(Life_Male ~ Greenspace + Crime + Smoking + Episodes)
summary(model3)

# Refined model after removing Crime
model3a <- lm(Life_Male ~ Greenspace + Smoking + Episodes)
summary(model3a)

# Extended reduced model
model3b <- lm(
  Life_Male ~ Greenspace + Crime + Smoking +
    Episodes + Binge_Drink + Benefits
)
summary(model3b)

# Simplified model selected in the report
model4 <- lm(Life_Male ~ Benefits + Episodes)
summary(model4)

# Stepwise model shown in the report
model5 <- lm(Life_Male ~ Benefits + NonDom_Build + Smoking)
summary(model5)

# Compare nested models
anova(model2, model4, test = "F")
anova(model2, model5, test = "F")


# -----------------------------
# Multicollinearity and relative importance
# -----------------------------

# Requires car package
# sqrt(vif(model2)) > 2
# sqrt(vif(model3)) > 2
# sqrt(vif(model3a)) > 2
# sqrt(vif(model4)) > 2
# sqrt(vif(model5)) > 2

# Requires relaimpo package
# calc.relimp(model3a, type = "lmg", rela = TRUE)
# calc.relimp(model4, type = "lmg", rela = TRUE)
# calc.relimp(model5, type = "lmg", rela = TRUE)


# -----------------------------
# Logistic regression
# -----------------------------

mylogit2 <- glm(
  low_bwt ~ smoke + ethnic + mwt,
  family = "binomial",
  data = low.bwt
)

summary(mylogit2)

# Odds ratios
exp(coef(mylogit2))

# VIF check
# sqrt(vif(mylogit2)) > 2


# -----------------------------
# Poisson modelling
# -----------------------------

# The report states that Poisson and quasi-Poisson models were fitted
# for murder counts using Benefits, Greenspace and NonDom_Build.
# The exact original model object definitions are not shown in the report.

# Example model form matching the documented final model:
mypoiss3 <- glm(
  murder ~ Benefits + Greenspace + NonDom_Build,
  family = poisson,
  data = murder_data
)

summary(mypoiss3)
