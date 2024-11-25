#Load packages
library(corrplot)
library(GGally)
library(dplyr)
library(ggplot2)
library(reshape)

#Read the data and prepare it 
data  <- read.csv("census2003_2023.csv")
data.df <- as.data.frame(data)
#stat.desc(data.df)
#non numeric values 
type <- str(data.df)

columns_to_convert <- c("Year","Median.age..both.sexes", "Median.age..females", "Median.age..males", "Total.Fertility.Rate", "Infant.Mortality.Rate..Both.Sexes", "Infant.Mortality.Rate..Males", "Infant.Mortality.Rate..Females")

# Loop through each column and convert to numeric
for (col in columns_to_convert) {
  data.df[[col]] <- as.numeric(gsub(",", "", data.df[[col]]))
}
non_numeric_values <- sapply(data.df, function(x) sum(!grepl("^\\d+\\.?\\d*$", x)))
non_numeric_values
for (col in names(data.df)) {
  if (is.numeric(data.df[[col]])) {  
    non_numeric_values <- data.df[[col]][!grepl("^\\d+\\.?\\d*$", data.df[[col]])]
    data.df[[col]][data.df[[col]] %in% non_numeric_values] <- NA  # Convert non-numeric to NA
  }
}

#Remove rows that has '<NA>' variables
dataNA <- data.df[rowSums(is.na(data.df)) > 0,]
data_without_NA <- data.df[rowSums(is.na(data.df)) == 0,]

#Divide data according to year
data_2023 <- data_without_NA[which(data_without_NA$Year == '2023'),]
data_2003 <- data_without_NA[which(data_without_NA$Year == '2003'),]


#TASK 1

# Frequency distribution of numerical variables on the basis of Median age:

# Five number summary plus mean for each of the numerical variables: (add variance)
#summary(data_2023$Median.age..both.sexes)
summ_MAB=summary(data_2023$Median.age..both.sexes)
summ_MAM=summary(data_2023$Median.age..males)
summ_MAF=summary(data_2023$Median.age..females)
#summ_LEF=round(summary(data_2022$life.expectancy.females),2)
summ_all= list(summ_MAB,summ_MAM,summ_MAF)
df_summ <- data.frame(matrix(unlist(summ_all), nrow=length(summ_all), 
                             byrow=TRUE))
variables_ <- c("Median age of both sexex", "Median age of males"
                ,"Median age of Females")
df_summ  <- data.frame(variables_, df_summ)
colnames(df_summ) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                       "3rd Qu","Max")


# Frequency distribution of numerical variables on the basis of Mortality Rate:

# Five number summary plus mean for each of the numerical variables: (add variance)
summ_IMB=round(summary(data_2023$Infant.Mortality.Rate..Both.Sexes),2)
summ_IMM=round(summary(data_2023$Infant.Mortality.Rate..Males),2)
summ_IMF=round(summary(data_2023$Infant.Mortality.Rate..Females),2)
#summ_LEF=round(summary(data_2022$life.expectancy.females),2)
summ_all_m= list(summ_IMB,summ_IMM,summ_IMF)
df_summ_m <- data.frame(matrix(unlist(summ_all_m), nrow=length(summ_all_m), 
                               byrow=TRUE))
variables_m <- c("Infant Mortality of Both Sexes", "Infant Mortality of Males "
                 ,"Infant Mortality of Females")
df_summ_m  <- data.frame(variables_m, df_summ_m)
colnames(df_summ_m) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                         "3rd Qu","Max")
#Total fertility rate
TFR_summ=round(summary(data_2023$Total.Fertility.Rate),2)

#added for Median age and Mortality
df_summ
df_summ_m
TFR_summ
# Description using graphical methods for Life Expectancy: Histograms
MAB_Hist <- hist(data_2023$Median.age..both.sexes, 
                 main="Median Age Of Both Sexes for 2023", 
                 xlab="Median Age of Both Sexes",labels=TRUE)
MAM_Hist <- hist(data_2023$Median.age..males, 
                 main="Median Age of Of Males for 2023", 
                 xlab="Median Age Of Males",labels=TRUE)
MAF_Hist <-hist(data_2023$Median.age..females, 
                main="Median Age Of Females for 2023", 
                xlab="Median Age Of Females",labels=TRUE)

# Description using graphical methods for mortality: Histograms
IMB_Hist <- hist(data_2023$Infant.Mortality.Rate..Both.Sexes, 
                 main="Infant Mortality Rate Of Both Sexes for 2023", 
                 xlab="Infnant Mortality Rate  of Both Sexes",labels=TRUE)
IMM_Hist <- hist(data_2023$Infant.Mortality.Rate..Males, 
                 main="Infant Mortality Rate Of Males for 2023", 
                 xlab="Infant Mortality Rate Of  Males",labels=TRUE)
IMF_Hist <-hist(data_2023$Infant.Mortality.Rate..Females, 
                main="Infant Mortality Rate Of Females for 2023", 
                xlab="Infant Mortality RAte Of Females",labels=TRUE)
#total fertility rate representation
TFR_Hist <- hist(data_2023$Total.Fertility.Rate, 
                 main="Total Fertility Rate for 2023", 
                 xlab="Total Fertility Rate for 2023",labels=TRUE)
# Histogram showing the median age of both females and males 
# comparison reasons: (add the deep purple in the legend)
hist(data_2023$Median.age..both.sexes, main = 'Median age',
     col = rgb(1, 0, 0, 0.5),
     xlab = 'Median age in 2023',
     xlim = c(40, 100),
     ylim = c(0, 80))

hist(data_2023$Median.age..males,
     col = rgb(0, 0, 1, 0.5),
     add = TRUE)
legend('topright', c('Females', 'Males', 'Intersection'),
       fill=c(rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(146, 90, 204, maxColorValue = 255)))

# Histogram showing the life expectancy of both females and males for Under Age 5 Mortality 
# comparison reasons: (add the deep purple in the legend)
hist(data_2023$Infant.Mortality.Rate..Both.Sexes, main = 'Infant Motality',
     col = rgb(1, 0, 0, 0.5),
     xlab = 'Infant Mortalty for 2023',
     xlim = c(40, 100),
     ylim = c(0, 80))

hist(data_2023$Infant.Mortality.Rate..Males,
     col = rgb(0, 0, 1, 0.5),
     add = TRUE)
legend('topright', c('Females', 'Males', 'Intersection'),
       fill=c(rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(146, 90, 204, maxColorValue = 255)))



###Regions

unique(data_2023$Region)

R_Asia <- data_2023[data_2023$Region == 'Asia', ]
R_Oceania <- data_2023[data_2023$Region == 'Oceania', ]
R_Americas <- data_2023[data_2023$Region == 'Americas', ]
R_Europe <- data_2023[data_2023$Region == 'Europe', ]
R_Africa <- data_2023[data_2023$Region == 'Africa', ]
#R_Europe


####Statistical Method for differentiating between the Regions(Median age)
# Five number summary for Asia
RAs_summ_MAB=round(summary(R_Asia$Median.age..both.sexes),2)
RAs_summ_MAM=round(summary(R_Asia$Median.age..males),2)
RAs_summ_MAF=round(summary(R_Asia$Median.age..females),2)
summ_all_RAs= list(RAs_summ_MAB,RAs_summ_MAM,RAs_summ_MAF)
df_summ_RAs <- data.frame(matrix(unlist(summ_all_RAs), nrow=length(summ_all_RAs), 
                                 byrow=TRUE))
variables_RAs <- c("Median age of both sexes in Asia", "Median age of males in Asia"
                   ,"Median age of Females in Asia")
df_summ_RAs  <- data.frame(variables_RAs, df_summ_RAs)
colnames(df_summ_RAs) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                           "3rd Qu","Max")
# Five number summary for Europe
RE_summ_MAB=round(summary(R_Europe$Median.age..both.sexes),2)
RE_summ_MAM=round(summary(R_Europe$Median.age..males),2)
RE_summ_MAF=round(summary(R_Europe$Median.age..females),2)
summ_all_RE= list(RE_summ_MAB,RE_summ_MAM,RE_summ_MAF)
df_summ_RE <- data.frame(matrix(unlist(summ_all_RE), nrow=length(summ_all_RE), 
                                byrow=TRUE))
variables_RE <- c("Median age of both sexes in Europe", "Median age of males in Europe"
                  ,"Median age of Females in Europe")
df_summ_RE  <- data.frame(variables_RE, df_summ_RE)
colnames(df_summ_RE) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                          "3rd Qu","Max")
## Five number summary for Africa
RAf_summ_MAB=round(summary(R_Africa$Median.age..both.sexes),2)
RAf_summ_MAM=round(summary(R_Africa$Median.age..males),2)
RAf_summ_MAF=round(summary(R_Africa$Median.age..females),2)
summ_all_RAf= list(RAf_summ_MAB,RAf_summ_MAM,RAf_summ_MAF)
df_summ_RAf <- data.frame(matrix(unlist(summ_all_RAf), nrow=length(summ_all_RAf), 
                                 byrow=TRUE))
variables_RAf <- c("Median age of both sexes in Africa", "Median age of males in Africa"
                   ,"Median age of Females in Africa")
df_summ_RAf  <- data.frame(variables_RAf, df_summ_RAf)
colnames(df_summ_RAf) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                           "3rd Qu","Max")
# Five number summary for Oceana
RO_summ_MAB=round(summary(R_Oceania$Median.age..both.sexes),2)
RO_summ_MAM=round(summary(R_Oceania$Median.age..males),2)
RO_summ_MAF=round(summary(R_Oceania$Median.age..females),2)
summ_all_RO= list(RO_summ_MAB,RO_summ_MAM,RO_summ_MAF)
df_summ_RO <- data.frame(matrix(unlist(summ_all_RO), nrow=length(summ_all_RO), 
                                byrow=TRUE))
variables_RO <- c("Median age of both sexes in Oceania", "Median age of males in Oceania"
                  ,"Median age of Females in Oceania")
df_summ_RO  <- data.frame(variables_RO, df_summ_RO)
colnames(df_summ_RO) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                          "3rd Qu","Max")
# Five number summary for Americas
RAm_summ_MAB=round(summary(R_Americas$Median.age..both.sexes),2)
RAm_summ_MAM=round(summary(R_Americas$Median.age..males),2)
RAm_summ_MAF=round(summary(R_Americas$Median.age..females),2)
summ_all_RAm= list(RAm_summ_MAB,RAm_summ_MAM,RAm_summ_MAF)
df_summ_RAm <- data.frame(matrix(unlist(summ_all_RAm), nrow=length(summ_all_RAm), 
                                 byrow=TRUE))
variables_RAm <- c("Median age of both sexes in America", "Median age of males in America"
                   ,"Median age of Females in America")
df_summ_RAm  <- data.frame(variables_RAm, df_summ_RAm)
colnames(df_summ_RAm) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                           "3rd Qu","Max")
bind_rows(df_summ_RAs,df_summ_RE,df_summ_RAf,df_summ_RO,df_summ_RAm)


###Graphical Representation(Median age )Box plots
r_plot_both <- ggplot(data_2023, aes(x=Region,y=Median.age..both.sexes, fill= region),sort = data_2023$Region)+
  geom_boxplot(aes(fill=Region))+  labs(x="Median age of Both Sexes",y="Region")
r_plot_both
r_plot_Males <- ggplot(data_2023, aes(x=Region,y=Median.age..males, fill= region),sort = data_2023$Region)+
  geom_boxplot(aes(fill=Region))+  labs(x="Median age of Males",y="Region")
r_plot_Males
r_plot_Females <- ggplot(data_2023, aes(x=Region,y=Median.age..females, fill= region),sort = data_2023$region)+
  geom_boxplot(aes(fill=Region))+  labs(x="Median age of Females",y="Region")
r_plot_Females
#####Statistical Method for differentiating between the Regions(Total Fertility Rate)
## Five number summary for Asia(Mortality)
RAs_summ_TFR=round(summary(R_Asia$Total.Fertility.Rate),2)
## Five number summary for Europe(Mortality)
RE_summ_TFR=round(summary(R_Europe$Total.Fertility.Rate),2)

## Five number summary for Africa(Mortality)
RAf_summ_TFR=round(summary(R_Africa$Total.Fertility.Rate),2)

## Five number summary for Oceania(Mortality)
RO_summ_TFR=round(summary(R_Oceania$Total.Fertility.Rate),2)


## Five number summary for America(Mortality)
RAm_summ_TFR=round(summary(R_Americas$Total.Fertility.Rate),2)


summ_all_TFR= list(RAs_summ_TFR,RE_summ_TFR,RAf_summ_TFR,RO_summ_TFR,RAm_summ_TFR)
df_summ_TFR <- data.frame(matrix(unlist(summ_all_TFR), nrow=length(summ_all_TFR), 
                                 byrow=TRUE))
variables_TFR <- c("Total Fertility Rate in Asia","Total Fertility Rate in Europe",
                   "Total Fertility Rate in Africa","Total Fertility Rate in Osceania",
                   "Total Fertility Rate in America")
df_summ_TFR  <- data.frame(variables_TFR, df_summ_TFR)
colnames(df_summ_TFR) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                           "3rd Qu","Max")
#graphical Representation 
rTFR_plot <- ggplot(data_2023, aes(x=Region,y=Total.Fertility.Rate, fill= region),sort = data_2023$Region)+
  geom_boxplot(aes(fill=Region))+  labs(x="Total fertility rate",y="Region")
rTFR_plot
###Mortality in Regions
df_summ_TFR

####Statistical Method for differentiating between the Regions(Mortality)
## Five number summary for Asia(Mortality)
RAs_summ_IMB=round(summary(R_Asia$Infant.Mortality.Rate..Both.Sexes),2)
RAs_summ_IMM=round(summary(R_Asia$Infant.Mortality.Rate..Males),2)
RAs_summ_IMF=round(summary(R_Asia$Infant.Mortality.Rate..Females),2)

summ_all_RmAs= list(RAs_summ_IMB,RAs_summ_IMM,RAs_summ_IMF)
df_summ_RmAs <- data.frame(matrix(unlist(summ_all_RmAs), nrow=length(summ_all_RmAs), 
                                  byrow=TRUE))
variables_RmAs <- c("Infant Mortality of Both Sexes in Asia", "Infant Mortality of Males in Asia "
                    ,"Infant Mortality of Females in Asia")
df_summ_RmAs  <- data.frame(variables_RmAs, df_summ_RmAs)
colnames(df_summ_RmAs) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                            "3rd Qu","Max")


## Five number summary for Europe(Mortality)
RE_summ_IMB=round(summary(R_Europe$Infant.Mortality.Rate..Both.Sexes),2)
RE_summ_IMM=round(summary(R_Europe$Infant.Mortality.Rate..Males),2)
RE_summ_IMF=round(summary(R_Europe$Infant.Mortality.Rate..Females),2)

summ_all_RmE= list(RE_summ_IMB,RE_summ_IMM,RE_summ_IMF)
df_summ_RmE <- data.frame(matrix(unlist(summ_all_RmE), nrow=length(summ_all_RmE), 
                                 byrow=TRUE))
variables_RmE <- c("Infant Mortality of Both Sexes in Europe", "Infant Mortality of Males in Europe "
                   ,"Infant Mortality of Females in Europe")
df_summ_RmE  <- data.frame(variables_RmE, df_summ_RmE)
colnames(df_summ_RmE) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                           "3rd Qu","Max")

## Five number summary for Africa(Mortality)
RAf_summ_IMB=round(summary(R_Africa$Infant.Mortality.Rate..Both.Sexes),2)
RAf_summ_IMM=round(summary(R_Africa$Infant.Mortality.Rate..Males),2)
RAf_summ_IMF=round(summary(R_Africa$Infant.Mortality.Rate..Females),2)

summ_all_RmAf= list(RAf_summ_IMB,RAf_summ_IMM,RAf_summ_IMF)
df_summ_RmAf <- data.frame(matrix(unlist(summ_all_RmAf), nrow=length(summ_all_RmAf), 
                                  byrow=TRUE))
variables_RmAf <- c("Infant Mortality of Both Sexes in Africa", "Infant Mortality of Males in Africa "
                    ,"Infant Mortality of Females in Africa")
df_summ_RmAf  <- data.frame(variables_RmAf, df_summ_RmAf)
colnames(df_summ_RmAf) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                            "3rd Qu","Max")

## Five number summary for Oceania(Mortality)
RO_summ_IMB=round(summary(R_Oceania$Infant.Mortality.Rate..Both.Sexes),2)
RO_summ_IMM=round(summary(R_Oceania$Infant.Mortality.Rate..Males),2)
RO_summ_IMF=round(summary(R_Oceania$Infant.Mortality.Rate..Females),2)
summ_all_RmO= list(RO_summ_IMB,RO_summ_IMM,RO_summ_IMF)
df_summ_RmO <- data.frame(matrix(unlist(summ_all_RmO), nrow=length(summ_all_RmO), 
                                 byrow=TRUE))
variables_RmO <- c("Infant Mortality of Both Sexes In Oceania", "Infant Mortality of Males in Oceania "
                   ,"Infant Mortality of Females in Oceania")
df_summ_RmO  <- data.frame(variables_RmO, df_summ_RmO)
colnames(df_summ_RmO) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                           "3rd Qu","Max")

## Five number summary for America(Mortality)
RAm_summ_IMB=round(summary(R_Americas$Infant.Mortality.Rate..Both.Sexes),2)
RAm_summ_IMM=round(summary(R_Americas$Infant.Mortality.Rate..Males),2)
RAm_summ_IMF=round(summary(R_Americas$Infant.Mortality.Rate..Females),2)

summ_all_RmAm= list(RAm_summ_IMB,RAm_summ_IMM,RAm_summ_IMF)
df_summ_RmAm <- data.frame(matrix(unlist(summ_all_RmAm), nrow=length(summ_all_RmAm), 
                                  byrow=TRUE))
variables_RmAm <- c("Infant Mortality of Both Sexes in America", "Infant Mortality of Males in America"
                    ,"Infant Mortality of Females in America")
df_summ_RmAm  <- data.frame(variables_RmAm, df_summ_RmAm)
colnames(df_summ_RmAm) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                            "3rd Qu","Max")
###Mortality in Regions
bind_rows(df_summ_RmAs,df_summ_RmE,df_summ_RmAf,df_summ_RmO,df_summ_RmAm)

#### Graphical Representation(Mortality)
rM_plot_Both <- ggplot(data_2023, aes(x=Region,y=Infant.Mortality.Rate..Both.Sexes, fill= region),sort = data_2023$Region)+
  geom_boxplot(aes(fill=Region))+  labs(x="Infant Mortality of Both sexes",y="Region")
rM_plot_Both

rM_plot_Males <- ggplot(data_2023, aes(x=Region,y=Infant.Mortality.Rate..Males, fill= region),sort = data_2023$Region)+
  geom_boxplot(aes(fill=Region))+  labs(x="Infant Mortality of Males",y="Region")
rM_plot_Males
rM_plot_Females <- ggplot(data_2023, aes(x=Region,y=Infant.Mortality.Rate..Females, fill= region),sort = data_2023$Region)+
  geom_boxplot(aes(fill=Region))+  labs(x="Infant Mortality of Females",y="Region")
rM_plot_Females




#TASK 2

# Statistical method:
#EUROPE
#Median per subregion(median age) 
df_median_Life <-data.frame(R_Europe%>%
                              group_by(Year,Subregion)%>% 
                              summarise(Median_age_both=median(Median.age..both.sexes),
                                        Median_age_Males=median(Median.age..males),
                                        Median_age_Females=median(Median.age..females)))

df_median_Life
# IQR per subregion(Median age)
df_IQR_Life<-data.frame(R_Europe%>%
                          group_by(Year,Subregion)%>% 
                          summarise(Median_age_both=quantile(Median.age..both.sexes,0.75)-quantile(Median.age..both.sexes,0.25),
                                    Median_age_Males=quantile(Median.age..males,0.75)-quantile(Median.age..males,0.25),
                                    Median_age_Females=quantile(Median.age..females,0.75)-quantile(Median.age..females,0.25)))
df_IQR_Life

##Median per subregion(Total Fertility rate) 
df_median_TFR <-data.frame(R_Europe%>%
                             group_by(Year,Subregion)%>% 
                             summarise(Total.Fertility.Rate=median(Total.Fertility.Rate)))


df_median_TFR
# IQR per subregion(Median age)
df_IQR_TFR<-data.frame(R_Europe%>%
                         group_by(Year,Subregion)%>% 
                         summarise(Total.Fertility.Rate=quantile(Total.Fertility.Rate,0.75)-quantile(Total.Fertility.Rate,0.25) ))
df_IQR_TFR


#Median per subregion(Mortality)
df_median_Mortality <-data.frame(R_Europe%>%
                                   group_by(Year,Subregion)%>% 
                                   summarise(Mortality_Of_BothSexes=median(Infant.Mortality.Rate..Both.Sexes),
                                             Mortality_Of_Males=median(Infant.Mortality.Rate..Males),
                                             Mortality_Of_Females=median(Infant.Mortality.Rate..Females)))




df_median_Mortality
# IQR per subregion(Mortality)
df_IQR_Mortality<-data.frame(R_Europe%>%
                               group_by(Year,Subregion)%>% 
                               summarise(Mortality_Of_BothSexes=quantile(Infant.Mortality.Rate..Both.Sexes,0.75)-quantile(Infant.Mortality.Rate..Both.Sexes,0.25),
                                         Mortality_Of_Males=quantile(Infant.Mortality.Rate..Males,0.75)-quantile(Infant.Mortality.Rate..Males,0.25),
                                         Mortality_Of_Females=quantile(Infant.Mortality.Rate..Females,0.75)-quantile(Infant.Mortality.Rate..Females,0.25)))
df_IQR_Mortality

# Graphical Method:
arr <-  R_Europe %>% distinct(Subregion,Region) %>% arrange(Region)


LE_boxplots = ggplot(R_Europe, aes(x=Median.age..both.sexes,y=factor(Subregion,levels= arr$Subregion)
                                   , fill= Region),sort = R_Europe$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of both sexes",y="Subregion")

LEM_boxplots = ggplot(R_Europe, aes(x=Median.age..males,y=factor(Subregion,levels= arr$Subregion)
                                    , fill= Region),sort = R_Europe$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of Males",y="Subregion")

LEF_boxplots = ggplot(R_Europe, aes(x=Median.age..females,y=factor(Subregion,levels= arr$Subregion)
                                    , fill= Region),sort = R_Europe$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of Females",y="Subregion") 
M_boxplots = ggplot(R_Europe, aes(x=Infant.Mortality.Rate..Both.Sexes,y=factor(Subregion,levels= arr$Subregion)
                                  , fill= Region),sort = R_Europe$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Both Sexes",y="Subregion")

MM_boxplots = ggplot(R_Europe, aes(x=Infant.Mortality.Rate..Males,y=factor(Subregion,levels= arr$Subregion)
                                   , fill= Region),sort = R_Europe$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Males",y="Subregion")

MF_boxplots = ggplot(R_Europe, aes(x=Infant.Mortality.Rate..Females,y=factor(Subregion,levels= arr$Subregion)
                                   , fill= Region),sort = R_Europe$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Females",y="Subregion") 




TFR_boxplots = ggplot(R_Europe, aes(x=Total.Fertility.Rate,y=factor(Subregion,levels= arr$Subregion)
                                    , fill= Region),sort = R_Europe$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of Males",y="Subregion")

TFR_boxplots
LE_boxplots
LEM_boxplots
LEF_boxplots
M_boxplots
MM_boxplots
MF_boxplots

#AFRICA
Af_df_median_Life <-data.frame(R_Africa%>%
                                 group_by(Year,Subregion)%>% 
                                 summarise(Median_age_Both_sexes=median(Median.age..both.sexes),
                                           Median_age_Males=median(Median.age..males),
                                           Median_age_Females=median(Median.age..females)))

Af_df_median_Life
# IQR per subregion(Life Expectancy)
Af_df_IQR_Life<-data.frame(R_Africa%>%
                             group_by(Year,Subregion)%>% 
                             summarise(Median_age_Both_sexes=quantile(Median.age..both.sexes,0.75)-quantile(Median.age..both.sexes,0.25),
                                       Median_age_Males=quantile(Median.age..males,0.75)-quantile(Median.age..males,0.25),
                                       Median_age_Females=quantile(Median.age..females,0.75)-quantile(Median.age..females,0.25)))
Af_df_IQR_Life
##Median per subregion(Total Fertility rate) 
dfAf_median_TFR <-data.frame(R_Africa%>%
                               group_by(Year,Subregion)%>% 
                               summarise(Total.Fertility.Rate=median(Total.Fertility.Rate)))


dfAf_median_TFR
# IQR per subregion(Median age)
dfAf_IQR_TFR<-data.frame(R_Africa%>%
                           group_by(Year,Subregion)%>% 
                           summarise(Total.Fertility.Rate=quantile(Total.Fertility.Rate,0.75)-quantile(Total.Fertility.Rate,0.25) ))
dfAf_IQR_TFR
#Median per subregion(Mortality)
Af_df_median_Mortality <-data.frame(R_Africa%>%
                                      group_by(Year,Subregion)%>% 
                                      summarise(Mortality_Of_BothSexes=median(Infant.Mortality.Rate..Both.Sexes),
                                                Mortality_Of_Males=median(Infant.Mortality.Rate..Males),
                                                Mortality_Of_Females=median(Infant.Mortality.Rate..Females)))




Af_df_median_Mortality
# IQR per subregion(Mortality)
Af_df_IQR_Mortality<-data.frame(R_Africa%>%
                                  group_by(Year,Subregion)%>% 
                                  summarise(Mortality_Of_BothSexes=quantile(Infant.Mortality.Rate..Both.Sexes,0.75)-quantile(Infant.Mortality.Rate..Both.Sexes,0.25),
                                            Mortality_Of_Males=quantile(Infant.Mortality.Rate..Males,0.75)-quantile(Infant.Mortality.Rate..Males,0.25),
                                            Mortality_Of_Females=quantile(Infant.Mortality.Rate..Females,0.75)-quantile(Infant.Mortality.Rate..Females,0.25)))
Af_df_IQR_Mortality

# Graphical Method:
Af_arr <-  R_Africa %>% distinct(Subregion,Region) %>% arrange(Region)


Af_LE_boxplots = ggplot(R_Africa, aes(x=Median.age..both.sexes,y=factor(Subregion,levels= arr$Subregion)
                                      , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median Age of both sexes",y="Subregion")

Af_LEM_boxplots = ggplot(R_Africa, aes(x=Median.age..males,y=factor(Subregion,levels= arr$Subregion)
                                       , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of Males",y="Subregion")

Af_LEF_boxplots = ggplot(R_Africa, aes(x=Median.age..females,y=factor(Subregion,levels= arr$Subregion)
                                       , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of Females",y="Subregion") 
Af_M_boxplots = ggplot(R_Africa, aes(x=Infant.Mortality.Rate..Both.Sexes,y=factor(Subregion,levels= arr$Subregion)
                                     , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Both Sexes",y="Subregion")

Af_MM_boxplots = ggplot(R_Africa, aes(x=Infant.Mortality.Rate..Males,y=factor(Subregion,levels= arr$Subregion)
                                      , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Males",y="Subregion")

Af_MF_boxplots = ggplot(R_Africa, aes(x=Infant.Mortality.Rate..Females,y=factor(Subregion,levels= arr$Subregion)
                                      , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Females",y="Subregion") 






# Graphical Method:
arr <-  R_Africa %>% distinct(Subregion,Region) %>% arrange(Region)


Af_LE_boxplots = ggplot(R_Africa, aes(x=Median.age..both.sexes,y=factor(Subregion,levels= arr$Subregion)
                                      , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of both sexes",y="Subregion")

Af_LEM_boxplots = ggplot(R_Africa, aes(x=Median.age..males,y=factor(Subregion,levels= arr$Subregion)
                                       , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of Males",y="Subregion")


Af_LEF_boxplots = ggplot(R_Africa, aes(x=Median.age..females,y=factor(Subregion,levels= arr$Subregion)
                                       , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Median age of Females",y="Subregion") 
Af_M_boxplots = ggplot(R_Africa, aes(x=Infant.Mortality.Rate..Both.Sexes,y=factor(Subregion,levels= arr$Subregion)
                                     , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Both Sexes",y="Subregion")

Af_MM_boxplots = ggplot(R_Africa, aes(x=Infant.Mortality.Rate..Males,y=factor(Subregion,levels= arr$Subregion)
                                      , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Males",y="Subregion")

Af_MF_boxplots = ggplot(R_Africa, aes(x=Infant.Mortality.Rate..Females,y=factor(Subregion,levels= arr$Subregion)
                                      , fill= Region),sort = R_Africa$Region)+
  geom_boxplot(aes(fill=Region))+
  labs(x="Infant Mortality of Females",y="Subregion") 



Af_LE_boxplots
Af_LEM_boxplots
Af_LEF_boxplots
Af_M_boxplots
Af_MM_boxplots
Af_MF_boxplots
# TASK 3

# sample data
numeric_data <- data_2023[, 5:11] # Numerical variables
numeric_data <- numeric_data %>% select(-Total.Fertility.Rate)
groups <- data_2023[, c(2, 3)] # Factor variables

# Correlation between numerical variables:
# Statistical method:
# Select Median Age and Infant Mortality Rate variables
numeric_data <- data_2023[, 5:11] # Numerical variables
groups <- data_2023[, c(2, 3)] # Factor variables

# Graphical method:
selected_vars <- data_2023[, c("Median.age..both.sexes", "Median.age..females", "Median.age..males", 
                               "Infant.Mortality.Rate..Both.Sexes", "Infant.Mortality.Rate..Males", 
                               "Infant.Mortality.Rate..Females")]

# Calculating correlations among selected variables
correlation_matrix <- cor(selected_vars, use = "pairwise.complete.obs")


print(correlation_matrix)
# Graphical method:
library(GGally)
ggpairs(selected_vars)
#Heatmap
Correlation_numeric <- cor(numeric_data)
#print(Correlation_numeric)
# Heatmap for the correlation matrix
corrplot(Correlation_numeric, method = "number")

#4 TASK 4
#Statistical Method: roll-up by year

melted = melt(data_2023, id.vars = c("Year"),
              measure.vars =c( 'Median.age..both.sexes',
                               'Median.age..males',
                               'Median.age..females',
                               'Infant.Mortality.Rate..Both.Sexes',
                               'Infant.Mortality.Rate..Males',
                               'Infant.Mortality.Rate..Females'))

dfc <- data.frame(
  melted %>%
    group_by(Year, variable) %>%
    summarise(
      Q1st = quantile(value, 0.25, na.rm = TRUE),
      Mean = mean(value, na.rm = TRUE),
      Median = median(value, na.rm = TRUE),
      Q3rd = quantile(value, 0.75, na.rm = TRUE),
      IQR = quantile(value, 0.75, na.rm = TRUE) - quantile(value, 0.25, na.rm = TRUE)
    )
)

dfc
data_2003$Year <- as.numeric(data_2003$Year)
melted1 <- melt(data_2003, id.vars = c("Year"),
                measure.vars =  c( 'Median.age..both.sexes',
                                   'Median.age..males',
                                   'Median.age..females',
                                   'Infant.Mortality.Rate..Both.Sexes',
                                   'Infant.Mortality.Rate..Males',
                                   'Infant.Mortality.Rate..Females'))
dfc1 <- data.frame(
  melted1 %>%
    group_by(Year, variable) %>%
    summarise(
      Q1st = quantile(value, 0.25, na.rm = TRUE),
      Mean = mean(value, na.rm = TRUE),
      Median = median(value, na.rm = TRUE),
      Q3rd = quantile(value, 0.75, na.rm = TRUE),
      IQR = quantile(value, 0.75, na.rm = TRUE) - quantile(value, 0.25, na.rm = TRUE)
    )
)
dfc1
#Graphical Method:
DataExplorer::plot_boxplot(data_without_NA,by = 'Year')