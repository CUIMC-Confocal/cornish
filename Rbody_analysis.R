# commands for collecting data from Image.csv from R body colocalization workflow
# assumes imported as df

require(tidyverse)

# plot R bodies over time and R bodies in cells over time

dataName = "lysosome_xy02"

# calculate % of r bodies coloc over time
df_mod <- df %>% mutate(FxnRbodiesInVes = Count_RbodiesInVesicles/Count_RbodiesInCells, 
                        .after = Count_RbodiesInVesicles) %>%
  mutate(Timepoint = as.numeric(Metadata_Timepoint), .after = Metadata_Timepoint)


# plot 

# uses loess smoothing by default, not assuming any particular function

p_ves <- ggplot(df_mod, aes(x = Timepoint, y = FxnRbodiesInVes) ) +
  geom_point() +
  labs(title = dataName,
       x = "Timepoint",
       y = "Fraction of Cellular R Bodies >= 50% Overlapped with Vesicles (Max Proj)") +
  scale_x_continuous(breaks = seq(0, max(df_mod$Timepoint), by = 10)) # Forces labels at intervals of 10
p_ves

vesPlotName = paste0(dataName, "_overlap_plot.png")
ggsave(vesPlotName, plot = p_ves)

