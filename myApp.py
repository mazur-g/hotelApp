from flask import *
from flask_login import LoginManager,login_required
from myForms import RegisterForm
import psycopg2
from functools import wraps

""" Sprwadza czy uzytkownik jest zalogowany """
def is_logged_in(f):
    @wraps(f)
    def wrap(*args,**keyword):
        if 'logged_in' in session:
            return f(*args,**keyword)
        else:
            flash('Nieautoryzowany dostep, zaloguj sie','danger')
            return redirect(url_for('login'))
    return wrap


"""laczy sie z baza danyc i pobiera id_wlasciciela jesli istnieje """
conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
cur = conn.cursor()
query = "SELECT id_wlasciciela from wlasciciel_hotelu where data_do is null"
cur.execute(query)
try:
    id_w = str(cur.fetchone()[0])
except:
    id_w = None
    pass
conn.commit()
conn.close()

"""inicjuje aplikacje Flask"""
app = Flask(__name__)
app.config['SECRET_KEY'] = 'TOP_SECRET'
login_manager = LoginManager()
login_manager.init_app(app)
@app.route("/")
def index():
    return render_template("index.html")

"""wyswietla plik dashboard.html po wejsciu w sciezke /dashboard """
@app.route("/dashboard",methods=['GET','POST'])
@is_logged_in
def dashboard():
    return render_template("dashboard.html",id_w = id_w)

""" konwertuje wartosc typu bool na wartosc bitowa 1 lub 0 """
def convert(arg):
    if arg == u'true':
        return "b'1'"
    else:
        return "b'0'"

"""zwraca tablice zarezerwowanych pokojow przez danego klienta"""
def showReservedRooms():
        conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
        cur = conn.cursor()
        query = "SELECT * FROM zarezerwowanePokojeOsoby({0})".format(session['username'])
        cur.execute(query)
        allRows = cur.fetchall()
        result ="<table><tr><td>Numer pokoju</td><td>Ilu osobowy</td><td>Data zameldowania</td><td>Data wymeldowania</td><td>Telewizor</td><td>Wanna</td><td>Prysznic</td><td>Barek</td><td>Balkon</td></tr>"
        for row in allRows:
            result += "<tr>"
            for column in row:
                result+="<td>" + str(column) +"</td>"
            result += "</tr>"
        result+="</table>"
        conn.commit()
        conn.close()
        print result
        return result

"""zwraca tabele z dostepnymi pokojami """
def showAvailableRooms():
        conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
        cur = conn.cursor()
        query = "SELECT nr_pokoju,ilosc_miejsc,telewizor,wanna,prysznic,barek,balkon from dostepne_pokoje"
        cur.execute(query)
        rows = cur.fetchall()
        result = "<table><tr><td>Numer pokoju</td><td>Ilu osoboowy</td><td>Telewizor</td><td>Wanna</td><td>Prysznic</td><td>Barek</td><td>Balkon</td></tr>"
        for row in rows:
            result+="<tr>"
            for column in row:
                result += "<td>" + str(column) + "</td>"
            result+="</tr>"
        result += "</table>"
        conn.commit()
        conn.close()
        return result

"""rezerwuje pokoj danymi z wypelnionego formularza"""
def reserveRoomForm():
        """pobranie argumentow z zadania GET """
        amount_of_people = request.args.get('amount_of_people',0,type=int)
        amount_of_bed = request.args.get('amount_of_bed',0,type=int)
        date_from = request.args.get('date_from', 0)
        date_to = request.args.get('date_to', 0)
        tv = request.args.get('tv',0)
        bath = request.args.get('bath',0,)
        shower = request.args.get('shower',0)
        bar = request.args.get('bar',0)
        balcony = request.args.get('balcony',0)
        limousine = request.args.get('limousine',0)
        taxi = request.args.get('taxi',0)
        breakfast = request.args.get('breakfast',0)
        cleaning = request.args.get('cleaning',0)
        preparedData = [convert(x) for x in (tv,bath,shower,bar,balcony)]
        preparedData2 = [convert(x) for x in (limousine,taxi,breakfast,cleaning)]
        conn = psycopg2.connect("dbname='u5mazur' user='u5mazur' host='localhost'password='5mazur'") 
        cur = conn.cursor()
        query = "SELECT id_kategorii from kategoria where telewizor={0} and wanna={1} and prysznic={2} and barek={3} and balkon={4}".format(*preparedData) 
        cur.execute(query)
        category = cur.fetchone()
        query = "SELECT dostepny_pokoj_z_data('{0}','{1}',{2},{3})".format(date_from,date_to,category[0],amount_of_people)
        print query
        cur.execute(query)
        roomNumber = cur.fetchone()[0]
        if roomNumber:
            query = "SELECT id_udogodnienia from udogodnienia where limuzyna = {0} and taxi = {1} and sniadanie_do_pokoju = {2} and dodatkowe_sprzatanie = {3}".format(*preparedData2)
            cur.execute(query)
            id_ud = cur.fetchone()[0]
            try:
                query = "INSERT INTO wynajecie(id_klienta,nr_pokoju,data_od,data_do,id_udogodnienia,ilosc_podwojnych_lozek,ilosc_pojedynczych_lozek) values({0},{1},'{2}','{3}',{4},{5},{6})".format(session['username'],roomNumber,date_from,date_to,id_ud,amount_of_bed,amount_of_people - 2*amount_of_bed)
                print(query)
                cur.execute(query)
                conn.commit()
                conn.close()
                myResult = "Pomyslne zarezerwowano pokoj o numerze {0}".format(roomNumber)
                print(myResult)
                return myResult
            except psycopg2.Error,e:
                return e.diag.message_primary
        else:
            return "Nie znaleziono dostepnego pokoju w podanym terminie"
def reserveRoomWithNumber():
        conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
        cur = conn.cursor()
        date_from = request.args.get('date_from',0)
        date_to = request.args.get('date_to',0)
        roomNumber =  request.args.get('roomNumber',0)
        limousine = request.args.get('limousine',0)
        taxi = request.args.get('taxi',0)
        breakfast = request.args.get('breakfast',0)
        cleaning = request.args.get('cleaning',0)
        amount_of_bed = request.args.get('amount_of_bed',0,type=int)
        preparedData = [convert(x) for x in(limousine,taxi,breakfast,cleaning)]
        query = "SELECT id_udogodnienia from udogodnienia where limuzyna = {0} and taxi = {1} and sniadanie_do_pokoju = {2} and dodatkowe_sprzatanie = {3}".format(*preparedData)
        cur.execute(query)
        id_u = cur.fetchone()[0]
        query = "SELECT ilosc_miejsc from pokoj where nr_pokoju = {0}".format(roomNumber)
        cur.execute(query)
        amount_of_people = int(cur.fetchone()[0])
        try:
            query = "INSERT INTO wynajecie(id_klienta,nr_pokoju,data_od,data_do,id_udogodnienia,ilosc_podwojnych_lozek,ilosc_pojedynczych_lozek) values({0},{1},'{2}','{3}',{4},{5},{6})".format(session['username'],roomNumber,date_from,date_to,id_u,amount_of_bed,amount_of_people - 2*amount_of_bed)
            cur.execute(query)
            conn.commit()
            conn.close()
            return "Pozytwnie zarezerwowano pokoj o numerze {0}".format(roomNumber)
        except psycopg2.Error,e:
            conn.commit()
            conn.close()
            return e.diag.message_primary
       
"""zwraca tabele z najbardziej oplacalnymi pokojami"""       
def showMostPayfulRooms():
        conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
        cur = conn.cursor()
        query = "SELECT * from najbardziej_oplacalne"
        cur.execute(query)
        rows = cur.fetchall()
        result = "<table><tr><td>Numer pokoju</td><td>Calkowity przychod</td></tr>"
        for row in rows:
            result+= "<tr>"
            for column in row:
                result += "<td>" + str(column) + "</td>"
            result +="</tr>"
        conn.commit()
        conn.close()
        result += "</table>"
        return result

"""zwraca tabele z najczesciej wybieranymi pokojami"""
def showMostPickedRooms():
        conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
        cur = conn.cursor()
        query = "SELECT * from najczesciej_wynajmowane"
        cur.execute(query)
        rows = cur.fetchall()
        result = "<table><tr><td>Ile razy</td><td>Numer pokoju</td></tr>"
        for row in rows:
            result += "<tr>"
            for column in row:
                result += "<td>" + str(column) + "</td>"
            result +="</tr>"
        conn.commit()
        conn.close()
        result += "</table>"
        return result

"""dodaje konsjerza do bazy danych"""
def addConcierge():
    fname = request.args.get('fnameC',0)
    lname = request.args.get('lnameC',0)
    phone = request.args.get('phoneC',0)
    conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
    cur = conn.cursor()
    query = "INSERT INTO osoba(imie,nazwisko,nr_tel) values('{0}','{1}',{2})".format(fname,lname,phone)
    cur.execute(query)
    query = "SELECT id from osoba order by id desc limit 1"
    cur.execute(query)
    id_os = cur.fetchone()[0]
    query = "INSERT INTO konsjerz(id_konsjerza,data_od) values({0},NOW())".format(id_os)
    cur.execute(query)
    conn.commit()
    conn.close()
    return "Dodano nowego konsjerza"

"""dodaje pokoj do bazy danych"""
def addRoom():
    conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
    cur = conn.cursor()
    amount_of_people = request.args.get('amount_of_people',0)
    tv = request.args.get('tv',0)
    bath = request.args.get('tv',0)
    shower = request.args.get('shower',0)
    bar = request.args.get('bar',0)
    balcony = request.args.get('balcony',0)
    preparedData = [convert(x) for x in (tv,bath,shower,bar,balcony)]
    query = "SELECT id_kategorii from kategoria where telewizor={0} and wanna={1} and prysznic={2} and barek={3} and balkon={4}".format(*preparedData) 
    cur.execute(query)
    id_k = cur.fetchone()[0]
    query = "SELECT max(nr_pokoju) from pokoj where ilosc_miejsc = {0}".format(amount_of_people)
    cur.execute(query)
    nr_p = cur.fetchone()[0] + 1
    query = "INSERT INTO pokoj(nr_pokoju,id_kategorii,ilosc_miejsc) values({0},{1},{2})".format(nr_p,id_k,amount_of_people) 
    cur.execute(query)
    conn.commit()
    conn.close()
    return "Dodano nowy pokoj o numerze {0}".format(nr_p)

"""pokazuje rachunki danego klienta"""
def showBills():
    conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
    cur = conn.cursor()
    query = "SELECT id_wynajecia,nr_pokoju,rachunek from rachunki_klientow where id_klienta = {0}".format(session['username'])
    cur.execute(query)
    rows = cur.fetchall()
    result = "<table>"
    result +="<tr><td>Pokoj</td><td>Kwota do zaplaty</td></tr>"
    for row in rows:
        result+="<tr>"
        for column in row[1:]:
            result+="<td>" + str(column) + "</td>"
        kwota = row[2]
        id_w = row[0]
        if kwota > 0:
            id_w = str(id_w)
            result+="<td><button class='btn btn-primary' onclick='payBills(" + id_w + ")'>Zaplac</button></td></tr>"
        else:
            result+="</tr>"
    conn.commit()
    conn.close()
    print result
    return result

"""placi za dany rachunek"""
def payBills():
    id_w = request.args.get('id_wy',0)
    conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
    cur = conn.cursor()
    query = "UPDATE wynajecie set czy_uregulowano = 1 where id_wynajecia = {0}".format(id_w)
    cur.execute(query)
    conn.commit()
    conn.close()
    return "Pieniadze pobrane za pomoca karty kredytowej"


"""odpowiada za odpowiednie wywolanie metody w zaleznosci od zadania"""
@app.route('/_requests',methods=['GET','POST'])
@is_logged_in
def handleRequest():
    myRequest = request.args.get('req',0)
    myCase = {'reserveRoomForm':reserveRoomForm,
              'showReservedRooms':showReservedRooms,
              'showAvailableRooms' : showAvailableRooms,
              'reserveRoomWithNumber' : reserveRoomWithNumber,
              'showMostPayfulRooms' : showMostPayfulRooms,
              'showMostPickedRooms' : showMostPickedRooms,
              'addConcierge' : addConcierge,
              'addRoom' : addRoom,
              'showBills' : showBills,
              'payBills' : payBills}
    result = myCase[myRequest]()
    return result
    

"""loguje uzytkownika"""
@app.route("/login",methods=['GET','POST'])
def login():
    if request.method == 'POST':
        conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
        cur = conn.cursor()
        query = "SELECT haslo from osoba where id = {0}".format(request.form["user"])
        print query
        cur.execute(query) 
        row = cur.fetchone() 
        conn.commit()
        conn.close()
        if row: 
            user_password = row[0]
            print(user_password,request.form["password"])
            if user_password == request.form["password"]:
                session['logged_in'] = True
                session['username'] = request.form['user']
                flash('Zostales zalogowany','success')
                return redirect('dashboard')
            else:
                error = "Niepoprawne haslo" 
                return render_template('login.html',error=error)
        else:
            error = "Nie ma takiego uzytkownika"
            return render_template('login.html',error=error)

    return render_template("login.html")

"""wylogowuje uzytkownika"""
@app.route("/logout")
@is_logged_in
def logout():
    session.clear()
    flash("Zostales wylogowany",'success')
    return redirect(url_for("index"))

"""rejestrj uzytkownika"""
@app.route("/register",methods=['GET','POST'])
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        conn = psycopg2.connect("dbname='ykxpfnjf' user='ykxpfnjf' host='horton.elephantsql.com' password='KTZyWm5rnLaKh3FqoW2_XdDzz-fB_nNi'")
        cur = conn.cursor()
        query = "insert into osoba(imie,nazwisko,data_ur,nr_tel,haslo) values('{0}','{1}','{2}',{3},'{4}')".format(form.fname.data,form.lname.data,form.birth_date.data,form.phone.data,form.password.data) 
        print(query)
        cur.execute(query)
        query = "select id from osoba order by id desc limit 1"
        print(query)
        cur.execute(query)
        row = cur.fetchone()
        query = "insert into klient values({0},{1})".format(row[0],form.credit_card.data)
        print(query)
        cur.execute(query)
        conn.commit()
        conn.close()
        msg = "Zostales zarejestrowany, Twoje id to {0}, zaloguj sie".format(row[0])
        flash(msg,'success')
        return redirect(url_for('index'))
    return render_template('register.html', form=form)

