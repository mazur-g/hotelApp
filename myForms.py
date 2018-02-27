from wtforms import *

"""tworzy klase formularza do rejestracji"""
class RegisterForm(Form):
    fname = TextField('Imie',[validators.Required(message="Podaj imie")])
    lname = TextField('Nazwisko',[validators.Required(message="Podaj nazwisko")])
    birth_date = DateField('Data urodzenia',[validators.Required(message='Podaj date urodzenia')])
    credit_card = IntegerField('Numer karty kredytowej',[validators.Required(message="Musisz podac numery karty!"),validators.NumberRange(min=1000000000000000,max=9999999999999999,message="Numer karty kredytowej sklada sie z 16 cyfr")])
    phone = IntegerField('Numer telefonu',[validators.Required(message="Podaj numer telefonu"),validators.NumberRange(min=100000000,max=999999999,message="Numer telefon sklada sie z 9 cyfr!")])
    password = PasswordField('Haslo',[
        validators.DataRequired(),
        validators.EqualTo('confirm', message='Hasla sie nie zgadzaja')
        ])
    confirm = PasswordField('Potwierdz haslo')
