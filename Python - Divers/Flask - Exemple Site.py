from flask import Flask, request, flash, redirect, url_for
from flask import send_file
from werkzeug import secure_filename

import os

app = Flask(__name__)
app.secret_key = 'd66HR8dç"f_-àgjYYic*dh'

DOSSIER_UPS = '/home/fred/www/tp_upload/ups/'

def extension_ok(nomfic):
    """ Renvoie True si le fichier possède une extension d'image valide. """
    return '.' in nomfic and nomfic.rsplit('.', 1)[1] in ('png', 'jpg', 'jpeg', 'gif', 'bmp')

@app.route('/up/', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        if request.form['pw'] == 'up': # on vérifie que le mot de passe est bon
            f = request.files['fic']
            if f: # on vérifie qu'un fichier a bien été envoyé
                if extension_ok(f.filename): # on vérifie que son extension est valide
                    nom = secure_filename(f.filename)
                    f.save(DOSSIER_UPS + nom)
                    flash(u'Image envoyée ! Voici <a href="{lien}">son lien</a>.'.format(lien=url_for('upped', nom=nom)), 'suc
                else:
                    flash(u'Ce fichier ne porte pas une extension autorisée !', 'error')
            else:
                flash(u'Vous avez oublié le fichier !', 'error')
        else:
            flash(u'Mot de passe incorrect', 'error')
    return render_template('up_up.html')

@app.route('/up/view/')
def liste_upped():
    images = [img for img in os.listdir(DOSSIER_UPS) if extension_ok(img)] # la liste des images dans le dossier
    return render_template('up_liste.html', images=images)

@app.route('/up/view/<nom>')
def upped(nom):
    nom = secure_filename(nom)
    if os.path.isfile(DOSSIER_UPS + nom): # si le fichier existe
        return send_file(DOSSIER_UPS + nom, as_attachment=True) # on l'envoie
    else:
        flash(u'Fichier {nom} inexistant.'.format(nom=nom), 'error')
        return redirect(url_for('liste_upped')) # sinon on redirige vers la liste des images, avec un message d'erreur

if __name__ == '__main__':
    app.run(debug=True)
	
	
	

	