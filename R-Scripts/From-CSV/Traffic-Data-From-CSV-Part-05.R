ggplot(M05_24H_DL, aes(x=DayCorrected, y=Count, group=Reader.Identifier)) +
  coord_cartesian(xlim = c(1, 31)) +
  geom_line(aes(color=Reader.Identifier)) +
  theme(legend.position="none")

ggplot(M05_24H_DH, aes(HourCorrected)) +
  geom_bar(aes(weight = Count)) +
  scale_y_continuous(labels = comma)

ggplot(M05_24H_DH, aes(x=DayCorrected, group=HourCorrected)) +
  coord_cartesian(xlim = c(1, 31)) +
  geom_bar(aes(color=HourCorrected)) +
  theme(legend.position="none")

M05_24H_DL_SouthFirst_BenWhite <- M05_24H_DL[which(M05_24H_DL$Reader.Identifier == 'south_1st_benwhite'), ]

ggplot(M05_24H_DL_SouthFirst_BenWhite, aes(x=DayCorrected, y=Count, group=Reader.Identifier)) +
  coord_cartesian(xlim = c(1, 31)) +
  geom_line(aes(color=Reader.Identifier)) +
  theme(legend.position="none")


