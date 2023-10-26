from bottle import Bottle, jinja2_template as template, \
    request, redirect
from bottle import response
from models import connection, Book
from utils.util import Utils
from utils.auth import Auth
import routes

app = routes.app
auth = Auth()

@app.route('/add', method=['GET', 'POST'])
def add():
    # Authentication check
    auth.check_login()
    registId = ""
    form = {}
    kind = "登録"

    if request.method == 'GET':
        if request.query.get('id') is not None:
            book = connection.query(Book).filter\
                (Book.id_ == request.query.get('id')).first()
            form['name'] = book.name
            form['volume'] = book.volume
            form['author'] = book.author
            form['publisher'] = book.publisher
            form['memo'] = book.memo
            registId = book.id_
            kind = "編集"

        return template('add.html'
                        , form=form
                        , kind=kind
                        , registId=registId)

    elif request.method == 'POST':
        form['name'] = request.forms.decode().get('name')
        form['volume'] = request.forms.decode().get('volume')
        form['author'] = request.forms.decode().get('author')
        form['publisher'] = request.forms.decode().get('publisher')
        form['memo'] = request.forms.decode().get('memo')
        registId = ""
        
        if request.forms.decode().get('id') is not None:
            registId = request.forms.decode().get('id')
        errorMsg = Utils.validate(data=form)
        print(errorMsg)
        if request.forms.get('next') == 'back':
            return template('add.html'
                            , form=form
                            , kind=kind
                            , registId=registId)

        if  errorMsg == []:
            headers = ['著書名', '卷数', '著作者', '出版社', 'メモ']
            return template('confirm.html'
                            , form=form
                            , headers=headers
                            , registId=registId)
        else:
            return template('add.html'
                            , error=errorMsg
                            , kind=kind
                            , form=form
                            , registId=registId)

@app.route('/regist', method='POST')
def regist():
    auth.check_login()
    name = request.forms.decode().get('name')
    volume = request.forms.decode().get('volume')
    author = request.forms.decode().get('author')
    publisher = request.forms.decode().get('publisher')
    memo = request.forms.decode().get('memo')
    registId = request.forms.decode().get('id')

    if request.forms.get('next') == 'back':
        response.status = 307
        response.set_header("Location", '/add')
        return response
    else:
        if registId is not None:
            book = connection.query(Book).filter\
                (Book.id_ == registId).first()
            book.name = name
            book.volume = volume
            book.author = author
            book.publisher = publisher
            book.memo = memo
            connection.commit()
            connection.close()
        else:
            book = Book(
                name = name,
                volume = volume,
                author = author,
                publisher = publisher,
                memo = memo,
                delFlag = False)
            connection.add(book)
            connection.commit()
            connection.close()
        redirect('/list')

@app.route('/delete/<dataId>')
def delete(dataId):
    auth.check_login()
    book = connection.query(Book).filter\
        (Book.id_ == dataId).first()
    book.delFlg = True
    connection.commit()
    connection.close()
    redirect('/list')
