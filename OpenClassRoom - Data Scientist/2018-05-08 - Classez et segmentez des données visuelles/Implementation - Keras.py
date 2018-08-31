from keras.models import Sequential

from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D

from keras.layers import Flatten, Dense

from keras.applications.vgg16 import VGG16

from keras.preprocessing.image import load_img, img_to_array
from keras.applications.vgg16 import preprocess_input

from keras.applications.vgg16 import decode_predictions

from keras.applications.vgg16 import VGG16
from keras.layers import Dense

######################################################################

my_VGG16 = Sequential()  # Création d'un réseau de neurones vide 
my_VGG16 = Sequential()  # Création d'un réseau de neurones vide 

######################################################################
# Couche de convolution et de pooling

# Ajout de la première couche de convolution, suivie d'une couche ReLU
my_VGG16.add(Conv2D(64, (3, 3), input_shape=(224, 224, 3), padding='same', activation='relu'))

# Ajout de la deuxième couche de convolution, suivie  d'une couche ReLU
my_VGG16.add(Conv2D(64, (3, 3), padding='same', activation='relu'))

# Ajout de la première couche de pooling
my_VGG16.add(MaxPooling2D(pool_size=(2,2), strides=(2,2)))

######################################################################
# Couches finales fully connected

my_VGG16.add(Flatten())  # Conversion des matrices 3D en vecteur 1D

# Ajout de la première couche fully-connected, suivie d'une couche ReLU
my_VGG16.add(Dense(4096, activation='relu'))

# Ajout de la deuxième couche fully-connected, suivie d'une couche ReLU
my_VGG16.add(Dense(4096, activation='relu'))

# Ajout de la dernière couche fully-connected qui permet de classifier
my_VGG16.add(Dense(1000, activation='softmax'))


######################################################################
# Utilisation d'un CNN pré-entraîné

model = VGG16() # Création du modèle VGG-16 implementé par Keras


img = load_img('cat.jpg', target_size=(224, 224))  # Charger l'image
img = img_to_array(img)  # Convertir en tableau numpy

img = img.reshape((1, img.shape[0], img.shape[1], img.shape[2]))  # Créer la collection d'images (un seul échantillon)
img = preprocess_input(img)  # Prétraiter l'image comme le veut VGG-16

y = model.predict(img)  # Prédir la classe de l'image (parmi les 1000 classes d'ImageNet)

# Afficher les 3 classes les plus probables
print('Top 3 :', decode_predictions(y, top=3)[0])

######################################################################
# Transfert Learning
######################################################################

# Charger VGG-16 pré-entraîné sur ImageNet et sans les couches fully-connected
model = VGG16(weights="imagenet", include_top=False, input_shape=(224, 224, 3))

# Récupérer la sortie de ce réseau
x = model.output

# Ajouter la nouvelle couche fully-connected pour la classification à 10 classes
predictions = Dense(10, activation='softmax')(x)

# Définir le nouveau modèle
new_model = Model(inputs=model.input, outputs=predictions)


##########################################################################
# Stratégie 1 - Fine-Tuning Total

for layer in model.layers:
   layer.trainable = True

##########################################################################
# Stratégie 2 - Extraction de features

for layer in model.layers:
   layer.trainable = False

##########################################################################
# Stratégie 3 - Fine-Tuning partiel

# Ne pas entraîner les 5 premières couches (les plus basses) 
for layer in model.layers[:5]:
   layer.trainable = False

# Compiler le modèle 
new_model.compile(loss="categorical_crossentropy", optimizer=optimizers.SGD(lr=0.0001, momentum=0.9), metrics=["accuracy"])

# Entraîner sur les données d'entraînement (X_train, y_train)
model_info = new_model.fit(X_train, y_train, epochs=epochs, batch_size=batch_size, verbose=2)







