from wtforms import *

"""tworzy klase formularza do rejestracji"""
class RegisterForm(Form):
    fname = TextField('Imie',[validators.Required(message="Podaj imie")])
    lname = TextField('Nazwisko',[validators.Required(message="Podaj nazwisko")])
    birth_date = DateField('Data urodzenia',[validators.Required(message='Podaj date urodzenia')])
    phone = IntegerField('Numer telefonu',[validators.Required(message="Podaj numer telefonu"),validators.NumberRange(min=100000000,max=999999999,message="Numer telefon sklada sie z 9 cyfr!")])
    password = PasswordField('Haslo',[
        validators.DataRequired(),
        validators.EqualTo('confirm', message='Hasla sie nie zgadzaja')
        ])
    confirm = PasswordField('Potwierdz haslo')
