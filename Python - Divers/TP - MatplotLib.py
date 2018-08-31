# -*- coding: utf-8 -*-

import numpy as np
from matplotlib import pyplot as plt
from time import sleep

##################################################################################
x = np.arange(0,21,1)
y = x
plt.plot(x,y)
plt.show()

##################################################################################
plt.figure(1)       # je crée une figure dont le numéro 1
x = np.arange(10)   # je crée un tableau d'entier de 0 à 9
y = x

plt.plot(x, y, 'r') # je crée une courbe d'équation y=x - RED
plt.plot(x, y * y, 'g') # je crée une courbe d'équation y=x*x - GREEN
plt.xlabel('axes des x')
plt.ylabel('axes des y')
plt.title('figure de zero')
plt.show()      # j'affiche les 2 courbes

##################################################################################
plt.figure(1)
plt.plot(x, y, 'r')

plt.figure(2)
plt.plot(x, y * y, 'g')

plt.show()

##################################################################################

plt.figure(1)
plt.subplot(121)
plt.plot(x, y, 'r')

plt.subplot(122)
plt.plot(x, y * y, 'g')
plt.show()

##################################################################################
plt.grid(True)

sub1 = plt.subplot(121)
sub1.set_title('graphe 1')
sub1.plot(x,y,'r')
plt.xlabel('axes des x')
plt.ylabel('axes des y')

sub2 = plt.subplot(122)
sub2.set_title('graphe 2')
sub2.plot(x,y*y,'g')
plt.xlabel('axes des x')
#plt.ylabel('axes des y')

##################################################################################
plt.figure()
plt.grid(True)

eta = np.arange(10)
tau = np.exp(eta)

plt.plot(eta,tau,'bx-')
plt.xlabel(r'$\tau(\eta)$')
plt.ylabel(r'$\eta$')
plt.title(r'$\tau (\eta) = e^{\eta}$')

plt.show()

##################################################################################
matrice = np.array([[1, 1, 1], [1, 3, 1], [1, 1, 1]])
im1 = plt.matshow(matrice)
plt.colorbar(im1)
plt.show

##################################################################################
plt.ion()
nb_images = 10
tableau = np.random.normal(10, 10, (nb_images, 10, 10))
image = plt.imshow(tableau[0, :, :])

for k in np.arange(nb_images):
    print ("image numero: {}".format(k))
    image.set_data(tableau[k, :, :])
    plt.draw()
    sleep(0.1)


