#  Grid

## Exercice 1

###Expliquez ce qu’est LazyVGrid et pourquoi on l’utilise.
LazyVgrid est qui liste verticalement les items de son contenue. Ce conteneur permet un chargement différé qui améliore les performances de l'application.

###Expliquez les différents types de colonnes et pourquoi on utilise flexible ici
- Fixed : Les colonnes de type fixe ont une largeur constante et ne changent pas en fonction de l'espace disponible. Vous spécifiez la largeur fixe que vous souhaitez pour ces colonnes.
- Flexible : Les colonnes de type flexible s'ajustent en fonction de l'espace disponible. Vous spécifiez une largeur minimale pour ces colonnes, mais elles peuvent occuper plus d'espace si cela est nécessaire. Elles sont particulièrement utiles pour s'adapter aux différentes tailles d'écrans ou aux changements d'orientation.
- Adaptable : Les colonnes de type adaptable combinent les avantages des colonnes fixes et flexibles. Elles ont une largeur initiale fixe mais peuvent devenir flexibles si cela est nécessaire. Vous spécifiez une largeur fixe initiale et une largeur maximale pour ces colonnes.

Dans notre exemple, nous voulons que l'image fasse toutes la largeur de l'écran en s'adaptant au écran.

###Votre grille ne doit pas être très jolie, expliquez pourquoi les images prennent toute la largeur de l’écran.
Dans cet exemple, les images prennent toute la largeur de l'écran car nous avons défini les colonnes avec une largeur flexible et minimale de 150 pixels. Si l'espace disponible est plus large, les colonnes s'ajusteront en conséquence.

## Exercice 2

###Expliquer ce que fait ce modifier ligne par ligne
comment -> ContentView
