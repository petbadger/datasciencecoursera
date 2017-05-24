#install.packages("readODS")
library(readODS)
distros <- read_ods(path = "distrowatch_data.ods", sheet = 2, col_names = TRUE, col_types = NULL,
                    na = "", skip = 0, formula_as_formula = FALSE, range = NULL)
hdr <- c("Rank", "Distribution", "HitsPerDay", "Year")
names(distros) <- hdr

#install.packages("plotly")

library(plotly)

#get top 20 from Year 1
top10 <- distros[1:10 , ]


#find those same ones from previous years.
library(dplyr)

top10overtime <- distros %>%
  filter(Distribution %in% top10$Distribution)


#plot
#p <- plot_ly(top10overtime, x = ~Year, y = ~Rank, text = ~Distribution, type = 'scatter', mode = 'markers',
#             marker = list(size = ~HitsPerDay, opacity = 0.5)) %>%
#  layout(title = 'Top 10 Distributions from 2016: A Look Back',
#         xaxis = list(showgrid = FALSE),
#         yaxis = list(showgrid = FALSE))
#p


#p <- plot_ly(top10overtime, x = ~Year, y = ~Rank, text = ~Distribution, type = 'scatter', mode = 'markers', size = ~HitsPerDay, color = ~Distribution, colors = 'Paired',
#             marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
#  layout(title = 'Distrowatch',
#         xaxis = list(showgrid = FALSE),
#         yaxis = list(showgrid = FALSE),
#         showlegend = FALSE)
#p


ubuntu <- distros %>%
  filter(Distribution %in% c("Ubuntu", "Mint", "Debian") )

#p <- plot_ly(ubuntu, x = ~Year, y = ~Rank, text = ~Distribution, type = 'scatter', mode = 'markers',
#             marker = list(size = ~HitsPerDay, opacity = 0.5)) %>%
#  layout(title = 'Ubuntu: A Look Back',
#         xaxis = list(showgrid = FALSE),
#         yaxis = list(showgrid = FALSE))
#p

#p <- plot_ly(ubuntu, x = ~Year, y = ~Rank, text = ~Distribution, type = 'scatter', mode = 'markers', size = ~HitsPerDay, 
#             marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
#  layout(title = 'Ubuntu',
#         xaxis = list(showgrid = FALSE),
#         yaxis = list(showgrid = FALSE),
#         showlegend = FALSE)
#p

#p <- plot_ly(ubuntu, x = ~Year, y = ~HitsPerDay, text = ~Distribution, type = 'scatter', mode = 'markers', size = ~HitsPerDay, 
#             marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
#  layout(title = 'Ubuntu',
#         xaxis = list(showgrid = FALSE),
#         yaxis = list(showgrid = FALSE),
#         showlegend = FALSE)
#p


p <- plot_ly(ubuntu, x = ~Year, y = ~HitsPerDay, text = ~Distribution, type = 'scatter', mode = 'markers', size = ~HitsPerDay, color = ~Distribution, colors = 'Paired',
             marker = list(opacity = 0.7, sizemode = 'diameter')) %>%
  layout(title = 'History of Ubuntu, Mint and Debian Linux Distributions on Distrowatch.com',
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE),
         showlegend = FALSE)
p
