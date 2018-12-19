from flask import Flask
from flask import make_response
from PIL import Image
from io import BytesIO

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello !"

@app.route('/contact')
def contact():
    mail = "jean@bon.fr"
    tel = "01 23 45 67 89"
    return "Mail: {} --- Tel: {}".format(mail, tel)    

@app.route('/la')
def ici():
	return "Everywhere !!!"

@app.route('/discussion')	
@app.route('/discussion/page/<num_page>')
def message(num_page=1):
	num_page = int(num_page)
	premier_message = 1 + 50*(num_page-1)
	dernier_message = premier_message + (50-1)
	return 'Affichage des messages {} à {}'.format(premier_message,dernier_message)

@app.route('/afficher')
@app.route('/afficher/<nom>.<prenom>')
def afficher(nom=None,prenom=None):
	if nom==None or prenom==None:
		return 'You must enter a correct format for your name your first name !!!'
	else:
		return "Hello {} - {} ".format(prenom,nom)

@app.route('/image')
def image():
	my_Picture = BytesIO()
	Image.new("RGB", (300,300), "#92C41D").save(my_Picture, 'BMP')
	answer = make_response(my_Picture.getvalue())
	answer.mimetype = "image/bmp"
	return answer

@app.route('/404')
def page_non_trouvee():
    return "Cette page devrait vous avoir renvoyé une erreur 404", 404

@app.errorhandler(401)
@app.errorhandler(404)
@app.errorhandler(500)
def my_error_page(error):
	return "My beautiful page {}".format(error.code),error.code
	
if __name__ == '__main__':
    app.run(debug=True)


	
	
	