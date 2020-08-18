# Pipeline COde_ Jasmin Fernandez Castillo (they, them, theirs)
# August 2020
# intermediate Gen Data training


### ODBC Connection
library(DBI)
library(RPostgres)
gendata_con <- DBI::dbConnect(odbc::odbc(),
                              #Driver   = "PostgreSQL ANSI(x64)",
                              Driver   = "PostgreSQL Unicode(x64)",
                              Server   = "generationdata.c9g5wowukaqz.us-east-1.rds.amazonaws.com",
                              Database = "generationdata",
                              UID      = "gendata_student",
                              PWD      = "wearethemovement",
                              Port     = 5432)


# reading  table as an R object

ga_absentee_records<-dbReadTable(gendata_con, c("ga_absentee"))

# getting the dimensions of the data set- rows and columns
dim(ga_absentee_records)

# names of columns
names(ga_absentee_records)

# subset with variables of interest
subset1  <- ga_absentee_records[ , c(11, 19:27, 31,37,39)]


# frequencies per level of column
table(as.factor(subset1$challengedprovisional))


# another subset based on variable value of 2 columns
hi<-(subset1[(subset1$challengedprovisional=="YES"& subset1$ballot_style=="MAILED" ),])


# frequencies of column level
table(subset1$ballot_style=="MAILED")
## the large  majority of voters voted by mail
## 616,912

# frequencies of column level
table(subset1$challengedprovisional=="YES")
## and only 1266 ballots were challenged

# frequencies of column level
table(subset1$challengedprovisional=="YES"& subset1$ballot_style=="MAILED")
## so folks who voted by mail and had their ballot challenged were 1262--  they make up almost 
# 100% of the ballots challenged



# 1262 had their provisional challenged and voted by mail-- this out of approx 78k observations
table(subset1$challengedprovisional=="YES"& subset1$ballot_style=="MAILED" & subset1$party=="DEMOCRAT")
## 667


## freqeuncies of 3 conditions met 
table(subset1$challengedprovisional=="YES"& subset1$ballot_style=="MAILED" & subset1$party=="NON-PartISAN")
## none were true for this one

## freqeuncies of 3 conditions met 
table(subset1$challengedprovisional=="YES"& subset1$ballot_style=="MAILED" & subset1$party=="REPUBLICAN")
# 332 were trye for this one. 


# changing variables to be read as factors
levels(as.factor(subset1$party))
subset1$party <- as.factor(subset1$party)
levels(subset1$party)

names(subset1)
levels(as.factor(subset1$application_status))
subset1$application_status <- as.factor(subset1$application_status)
levels(subset1$application_status)

table(subset1$party)

levels(as.factor(subset1$ballot_status))
subset1$ballot_status <- as.factor(subset1$ballot_status)
levels(subset1$ballot_status)

names(subset1)
# ballot_return_date
levels(as.factor(subset1$ballot_return_date))
subset1$ballot_return_date <- as.factor(subset1$ballot_return_date)
levels(subset1$ballot_return_date)

# Question for future research: what does level 1900-01-01 stand for? and 9091-08-11, and 9973-02-14

names(subset1)
levels(as.factor(subset1$application_status))
subset1$application_status <- as.factor(subset1$application_status)
levels(subset1$application_status)


# looking at column values for variabls
levels(as.factor(subset1$ballot_style))


levels(as.factor(subset1$status_reason))


levels(as.factor(subset1$application_status))

# converting variable to factor
subset1$challengedprovisional<-as.factor(subset1$challengedprovisional)

# inspecting factor frequencies
table(subset1$challengedprovisional)

## cross tab
# source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")-- croos tab function code within this link
crosstab <- function (..., dec.places = NULL,
                      type = NULL,
                      style = "wide",
                      row.vars = NULL,
                      col.vars = NULL,
                      percentages = TRUE, 
                      addmargins = TRUE,
                      subtotals=TRUE)

crosstab(subset1, row.vars = "challengedprovisional", col.vars = "challengedprovisional", type = c("f", "r"))


# looking at variable frequencies
table(as.factor(subset1$application_status))

# looking at variable values
levels(as.factor(ga_absentee_records$status_reason))