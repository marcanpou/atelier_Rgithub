library(tidyverse)
library(ratdat)

# exploration des données
?complete_old
summary(complete_old)
head(complete_old)
str(complete_old)

#### GGplot
library(ggplot2)

ggplot(data = complete_old,
       mapping = aes(x = weight, y = hindfoot_length))+
  geom_point(alpha = 0.2)

complete_old <- filter(complete_old, !is.na(weight) & !is.na(hindfoot_length))

ggplot(data = complete_old,
       mapping = aes(x = weight, y = hindfoot_length, colour = plot_id))+
  geom_point(alpha = 0.2, color = complete_old$plot_id)

#forme des points varie selon le sex
ggplot(data = complete_old,
       mapping = aes(x = weight, y = hindfoot_length, shape = sex))+
  geom_point(alpha = 0.5)

ggplot(data = complete_old,
       mapping = aes(x = weight, y = sex))+
  geom_point(alpha = 0.5)
#Couleur varie entre les années
ggplot(data = complete_old,
       mapping = aes(x = weight, y = hindfoot_length, color = year))+
  geom_point(alpha = 0.5)


ggplot(data = complete_old,
       mapping = aes(x = weight, y = hindfoot_length, color = plot_type))+
  geom_point(alpha = 0.5)+scale_color_viridis_d()

#ajouter une xcale pour le X 
ggplot(data = complete_old,
       mapping = aes(x = weight, y = hindfoot_length, color = plot_type))+
  geom_point(alpha = 0.5)+
  scale_color_viridis_d()+
  scale_x_log10()

## ET pout faire un boxplot ?

ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length))+
  geom_boxplot()+
  scale_x_discrete(labels = label_wrap_gen(width = 10))#scale pour changer en X
#Pour labels, regarder sur stack overflow

#On peut ajouter les données brut sur le boxplot
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length))+
  geom_boxplot()+
  geom_jitter(alpha=0.1)+#jitter nous permets de avoir les points de façon aléatoire
  scale_x_discrete(labels = label_wrap_gen(width = 10))

#Changer la couleur selon le plot type
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length, color = plot_type))+
  geom_boxplot()+
  geom_jitter(alpha=0.1)+
  scale_x_discrete(labels = label_wrap_gen(width = 10))

#Pour que la couleur soit juste dans les points
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length))+
  geom_boxplot()+
  geom_jitter(alpha=0.1, aes(color = plot_type))+
  scale_x_discrete(labels = label_wrap_gen(width = 10))
#pour changer les points noir, ou les outliers
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length))+
  geom_boxplot(outlier.shape = NA)+
  geom_jitter(alpha=0.1, aes(color = plot_type))+
  scale_x_discrete(labels = label_wrap_gen(width = 10))
#maintent, pour mettre le boxplot en avant
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length))+
  geom_jitter(alpha=0.1, aes(color = plot_type))+
  geom_boxplot(outlier.shape = NA, fill = NA)+
  scale_x_discrete(labels = label_wrap_gen(width = 10))

###
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length, fill = plot_type))+
  geom_jitter(alpha=0.1, aes(color = plot_type))+
  geom_violin(fill = NA)+
  scale_x_discrete(labels = label_wrap_gen(width = 10))

#pour ajouter un thème
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length, fill = plot_type))+
  geom_jitter(alpha=0.1, aes(color = plot_type))+
  geom_violin(fill = NA)+
  scale_x_discrete(labels = label_wrap_gen(width = 10))+
  theme_bw()

#utiliser la fonction theme pour changer quelque chose de particulier
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length, fill = plot_type))+
  geom_jitter(alpha=0.1, aes(color = plot_type))+
  geom_violin(fill = NA)+
  scale_x_discrete(labels = label_wrap_gen(width = 10))+
  theme_bw()+
  theme(legend.position = 'none')+#pour changer le titre des axes
  labs(x = 'Plot type', y = 'Hindfoot length (mm)')

#pour créer des graphs selon le sex
ggplot(data = complete_old,
       mapping = aes(x = plot_type, y = hindfoot_length, fill = plot_type))+
  geom_jitter(alpha=0.1, aes(color = plot_type))+
  geom_boxplot(outlier.shape = NA, fill = NA)+
  facet_wrap(vars(sex), ncol = 1)+
  scale_x_discrete(labels = label_wrap_gen(width = 10))+
  theme_bw()+
  theme(legend.position = 'none')+#pour changer le titre des axes
  labs(x = 'Plot type', y = 'Hindfoot length (mm)')

#et on peut toute le mettre dans un objet
plot_final = ggplot(data = complete_old,
                    mapping = aes(x = plot_type, y = hindfoot_length, fill = plot_type))+
  geom_jitter(alpha=0.1, aes(color = plot_type))+
  geom_boxplot(outlier.shape = NA, fill = NA)+
  facet_wrap(vars(sex), ncol = 1)+
  scale_x_discrete(labels = label_wrap_gen(width = 10))+
  theme_bw()+
  theme(legend.position = 'none')+#pour changer le titre des axes
  labs(x = 'Plot type', y = 'Hindfoot length (mm)')
plot_final
#pour sauvegarder le graphique
ggsave(filename = 'figures/plot_final.png', 
       plot = plot_final,
       height = 6,
       width = 8)
