from MontyHall_Joueur import joueur
from MontyHall_Presentateur import presentateur
from MontyHall_Portes import portes
from MontyHall_Partie import partie

from numpy import random as rand
import matplotlib.pyplot as plt 
import numpy as np

class simulation:

    def __init__(self,NombreSimulation):
        self.nombreSimulations = NombreSimulation
        self.grilleSimulationSansChgtChoix = np.empty(NombreSimulation)
        self.grilleSimulationAvecChgtChoix = np.empty(NombreSimulation)
        self.grilleSimulation = np.empty(NombreSimulation)

    def simuler(self,nombreSimulation,TypeStrategie):
        part = partie(joueur(TypeStrategie),presentateur())
        part.DemarrerPartie()
        if(TypeStrategie):
            self.grilleSimulationAvecChgtChoix[nombreSimulation] = part.RenvoyerResultatPartie()
        else:
            self.grilleSimulationSansChgtChoix[nombreSimulation] = part.RenvoyerResultatPartie()

    def simulation(self,nombreSimulation,TypeStrategie):
        if nombreSimulation == 0:
            self.simuler(nombreSimulation-1,TypeStrategie)
        else:
            self.simuler(nombreSimulation-1,TypeStrategie)
            self.simulation(nombreSimulation-1,TypeStrategie)

    def demarrerSimulation(self):
        print("---------------------------------------------------------------------------")
        print("Nombre de parties jouées : {}".format(self.nombreSimulations))
        print("---------------------------------------------------------------------------")
        print("Simulation avec changement du choix initial :")
        self.simulation(self.nombreSimulations,True)        
        print("Nombre de parties gagnées : {}".format(np.sum(self.grilleSimulationAvecChgtChoix[:])))
        print("Probabilité de gain : {}".format(np.sum(self.grilleSimulationAvecChgtChoix[:])/self.nombreSimulations))
        print("---------------------------------------------------------------------------")
        print("Simulation sans changement du choix initial :")
        self.simulation(self.nombreSimulations,False)
        print("Nombre de parties gagnées : {}".format(np.sum(self.grilleSimulationSansChgtChoix[:])))
        print("Probabilité de gain : {}".format(np.sum(self.grilleSimulationSansChgtChoix[:])/self.nombreSimulations))
        print("---------------------------------------------------------------------------")

        self.AfficherResultatsGraphiques()

    def AfficherResultatsGraphiques(self):
        histogramme = plt.bar(
                        [0,1],
                        [np.sum(self.grilleSimulationSansChgtChoix[:])/self.nombreSimulations,
                         np.sum(self.grilleSimulationAvecChgtChoix[:])/self.nombreSimulations],
                        tick_label=["Sans Changement","Avec Changement"])

# Effectuer 500 simulations du Monty Hall :
sim = simulation(1000)
sim.demarrerSimulation()





