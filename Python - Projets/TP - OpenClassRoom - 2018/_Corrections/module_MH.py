import numpy as np
import module_Strat as Strategy

def play_game(strategie):
    '''Simule une partie du jeu Monty Hall.

    Cette fonction simule le choix de la porte par le participant,
    l'élimination d'une mauvaise porte par le présentateur, et le
    choix final. Elle ne retourne que le résultat de la partie, parce
    que nous n'aurons besoin que du résultat pour effectuer nos calculs.

    Args:
        strategie (Strategie): La stratégie du joueur

    Returns:
        bool: Le joueur a-t-il gagné?
    '''
    portes = np.arange(3)

    bonne_porte = np.random.randint(0,3)

    # Choix du joueur
    premier_choix = np.random.randint(0,3)

    # Il nous reste deux portes
    portes = np.delete(portes, premier_choix)

    # Le présentateur élimine une porte
    if premier_choix == bonne_porte:
        portes = np.delete(portes, portes[np.random.randint(0,1)])
    else:
        portes = np.array([bonne_porte])

    deuxieme_choix = 0

    # Le deuxieme choix depend de la strategie

    if strategie == Strategy.strat.CHANGER:
        deuxieme_choix = portes[0]
    elif strategie == Strategy.strat.GARDER:
        deuxieme_choix = premier_choix
    else:
        raise ValueError("Stratégie non reconnue!")

    return deuxieme_choix == bonne_porte

def play(strategie, nb_tours):
    '''Simule une suite de tours du jeu.

    Cette fonction renvoie les résultats de plusieurs parties
    du jeu Monty Hall sous forme d'une liste de gains par le
    joueur.

    Args:
        strategie (Strategie): La strategie du joueur
        nb_tours (int): Nombre de tours

    Returns:
        list: Liste des gains du joueurs à chaque partie
    '''

    result = np.array(list(map(lambda x : play_game(x),
                    np.tile(strategie, nb_tours))))

    return result
