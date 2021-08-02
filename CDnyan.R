# Visualize Collections 
# ...in Nyancats
# 2021-Junyan-31


# install.packages("remotes")
# remotes::install_github("R-CoderDotCom/ggcats@main")
# install.packages("rgbif")
# install.packages("SPARQL")
# install.packages("zoo")


library(zoo)
library(rgbif) # or library(SPARQL)
library(SPARQL)
library(ggplot2)
library(ggcats)
# library(gganimate)

gbif_id <- Sys.getenv("GBIF_ID") 
gbif_pw <- Sys.getenv("GBIF_PW")

collections <- organizations(query = "Collection")
collections$data$created2 <- substr(collections$data$created, 1, 7)
collections$data$created_mo <- as.yearmon(collections$data$created2)
collections$data$created_year <- as.Date.POSIXct(collections$data$created_mo)
# collections$data$created_mo <- as.Date(collections$data$created2, format = "%Y-%m-%d")

coll_counts <- dplyr::count(collections$data, created_mo)
colnames(coll_counts) <- c("MonthCreated", "Collecnyans")

# coll_counts2 <- dplyr::count(collections$data, created_year)
# colnames(coll_counts2) <- c("DateCreated", "Collecnyans")


ggplot(coll_counts) +
  theme_classic() +
  theme(plot.background = element_rect(fill = "#F5F5DC")) +  # #FFFDD0
  theme(panel.background = element_rect(fill = "#75E6DA")) + # , colour = "light gray")) +
  theme(axis.line = element_line(colour = "dark turquoise")) +
  geom_cat(aes(MonthCreated, Collecnyans, cat = "nyancat"), size = 2, stat = "identity")

# ggplot(coll_counts2) +
#   geom_cat(aes(DateCreated, Collecnyans, cat = "nyancat"), size = 2, stat = "identity") +
#   transition_reveal(DateCreated)