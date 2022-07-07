library(ggplot2)
library(gganimate)
set.seed(4511)
prop <- rbinom(
  5000, 1,
  prob = 0.7
)
trials <- seq_along(prop)
prop <- cumsum(prop) / trials
df_prop <- data.frame(
  N = trials,
  Cumulative_Freq = prop
)

panim <- ggplot(
  df_prop,
  aes(
    x = N,
    y = Cumulative_Freq,
    label = Cumulative_Freq |> round(2)
  )
) +
  geom_line() +
  geom_point() +
  ylim(c(0, 1)) +
  geom_text(
    mapping = aes(
      x = N * 1.1
    ),
    size = 7,
    color = "red"
  ) +
  scale_x_log10() +
  geom_hline(yintercept = 0.7, color = "blue") +
  transition_reveal(N) +
  labs(
    title = "Núm. ensayos: {frame_along}",
    x = "Ensayos n", y = "Frec. acumulada"
  ) +
  theme_bw()

animate(panim, height = 480 * 0.7, width = 600 * 0.8)
anim_save("img/prop_animation.gif")