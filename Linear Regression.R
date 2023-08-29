# LINEAR REGRESSION

## **LOAD LIBRARIES**

```{r}
library(tidyverse)
library(ggpubr)
library(lawstat)
library(car)
library(emmeans)
library(gtsummary)
library(flextable)
library(report)
```

## **ATTACH DATA**

```{r}
df <- oranges
attach(df)
View(df)
?oranges
```

## **DESCRIPTIVE ANALYSIS**

```{r}
table1 <- tbl_summary(df, type=c(price1="continuous",
                                    price2="continuous"))
table1
```

## **LINEAR REGRESSION ASSUMPTIONS**

1.  Linear relationship: There exists a linear relationship between the independent variable and the dependent variable.

    ```{r}
    ggscatter(data=df,x="price1",y="sales1",add="reg.line",conf.int=T)
    ggscatter(data=df,x="price2",y="sales1",add="reg.line",conf.int=T)
    ```

2.  Independence: The residuals are independent. There should be no correlation between consecutive residuals in time series data.

3.  Homoscedasticity: The residuals have constant variance at every level of the independent variable.

    ```{r}
    plot(fitall$fitted.values,fitall$residuals)
    ```

4.  Normality: The residuals of the model are normally distributed.

    ```{r}
    qqnorm(fitall$residuals); qqline(fitall$residuals)
    ```

5.  Multicollinearity: No multicollinearity should exist between covariates in a regression model.

    ```{r}
    vif(fitall)
    ```

## **UNIVARIATE LINEAR REGRESSION MODELS**

```{r}
fit1 <- lm(sales1 ~ store, data=df)
fit2 <- lm(sales1 ~ day, data=df)
fit3 <- lm(sales1 ~ price1, data=df)
fit4 <- lm(sales1 ~ price2, data=df)
report(fit1); report(fit2); report(fit3); report(fit4)

table2 <- tbl_uvregression(df[c("store","day","price1","price2","sales1")], method=lm, y="sales1")
table2
```

## MULTIVARIATE LINEAR REGRESSION MODEL

```{r}
fitall <- lm(sales1 ~ store + day + price1 + price2, data=df)
report(fitall)

table3 <- tbl_regression(fitall)
table3

table4 <- tbl_merge(tbls = list(table2, table3), tab_spanner = c("**Univariate**", "**Multivariate**"))
table4
```
